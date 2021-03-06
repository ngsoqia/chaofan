<div class="container">
	<div class="row">
		<div class="col-md-4">
			<div class="visible-sm visible-xs">
				{include file='quick_jumps.tpl'}
			</div>		
			<div class="hidden-sm hidden-xs">
				{include file='user_info.tpl'}
			</div>
		</div>
		<div class="col-md-8">
			<div class="panel panel-default">
				<div class="panel-heading">
					{$user.username}{if $smarty.session.language == 'en_US'}&#39;s{/if} {t c='user.FRIENDS'}
				</div>
				<div class="panel-body">
					{if $friends}				
						<div class="btn-group">
							<button type="button" class="btn btn-default dropdown-toggle" data-toggle="dropdown">{if $order == 'invite_date'}{t c='user.recent_friends'}{elseif $order == 'recent_users'}{t c='user.recent_users'}{elseif $order == 'recent_logins'}{t c='user.recent_logins'}{else}{t c='global.username'}{/if} <span class="caret"></span></button>
							<ul class="dropdown-menu">
								<li {if $order == 'invite_date'}class="active"{/if}><a href="{url base="user/`$username`/friends" strip='o' value='invite_date'}">{t c='user.recent_friends'}</a></li>
								<li {if $order == 'recent_users'}class="active"{/if}><a href="{url base="user/`$username`/friends" strip='o' value='recent_users'}">{t c='user.recent_users'}</a></li>
								<li {if $order == 'recent_logins'}class="active"{/if}><a href="{url base="user/`$username`/friends" strip='o' value='recent_logins'}">{t c='user.recent_logins'}</a></li>
								<li {if $order == 'username'}class="active"{/if}><a href="{url base="user/`$username`/friends" strip='o' value='username'}">{t c='global.username'}</a></li>							
							</ul>
						</div>				
						<div class="clearfix"></div>
						<div id="remove_friend_message" class="m-t-15" style="display:none"></div>
						<div class="m-t-15">
							{t c='global.showing'} <span class="text-white">{$start_num}</span> {t c='global.to'} <span class="text-white">{$end_num}</span> {t c='global.of'} <span class="text-white">{$friends_total}</span> {t c='global.friends'}.
						</div>
						<div class="row">
									{section name=i loop=$friends}
										<div id="friend_{$friends[i].FID}" class="col-xs-6 col-md-3 m-t-15">
											<div class="thumb-overlay">
												<a href="{$relative}/user/{$friends[i].username}">
													<img src="{$relative}/media/users/{if $friends[i].photo == ''}nopic-{$friends[i].gender}.gif{else}{$friends[i].photo}{/if}" alt="{$friends[i].username}'s avatar" class="img-responsive"/>
													<div class="video-title title-truncate">{$friends[i].username|escape:'html'}</div>
												</a>
												{if isset($smarty.session.uid) && $smarty.session.uid == $user.UID}
													<div class="actions">
														<a href="#remove_friend" id="remove_profile_friend_{$friends[i].FID}" class="btn btn-danger btn-xs remove-btn hidden-xs">{t c='global.remove'}</a>
														<a href="#remove_friend" id="remove_profile_friend_{$friends[i].FID}" class="btn btn-danger remove-btn visible-xs"><i class="glyphicon glyphicon-remove"></i> {t c='global.remove'}</a>
													</div>
												{/if}
											</div>
										</div>                                                    
									{/section}
						</div>
						{if $page_link}
							<div style="text-align: center;" class="visible-xs">
								<ul class="pagination pagination-lg">{$page_link}</ul>
							</div>
							<div style="text-align: center;" class="hidden-xs">
								<ul class="pagination">{$page_link}</ul>
							</div>
						{/if}
					{else}
						<span class="text-danger">{t c='user.friends_none'}.</span>
					{/if}
				</div>				
			</div>	
		</div>
	</div>
</div>

