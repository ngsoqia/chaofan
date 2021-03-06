<script type="text/javascript" src="{$relative_tpl}/js/jquery.signup-0.1.js"></script>

<div class="container">
	
	<div class="row">
		<div class="col-md-6">
		<div class="well">
			<form class="form-horizontal" name="signup_form" id="signup_form" method="post" action="{$relative}/signup">
			  <fieldset>
				<legend>{t c='signup.title' s=$site_name}</legend>
				
					<div class="form-group {if $err.username}has-error{/if}">
						<label for="signup_username" class="col-lg-4 control-label">{t c='global.username'}</label>
						<div class="col-lg-8">
							<input name="username" type="text" class="form-control" value="{$signup.username}" id="signup_username" placeholder="{t c='global.username'}" />
							<div class="m-t-5">
								<a href="#check_username" id="check_username">{t c='signup.check'}</a>&nbsp;
								<span id="username_check_response" style="display:none;"></span>
								<span id="check_username_result" style="display: none;"></span>							
							</div>
						</div>
					</div>

					<div class="form-group {if $err.password}has-error{/if}">
						<label for="signup_password" class="col-lg-4 control-label">{t c='global.password'}</label>
						<div class="col-lg-8">
							<input name="password" type="password" class="form-control" value="" id="signup_password" placeholder="{t c='global.password'}" />
						</div>
					</div>

					<div class="form-group {if $err.password_confirm}has-error{/if}">
						<label for="signup_password_confirm" class="col-lg-4 control-label">{t c='global.password_confirm'}</label>
						<div class="col-lg-8">
							<input name="password_confirm" type="password" class="form-control" value="" id="signup_password_confirm" placeholder="{t c='global.password_confirm'}" />
						</div>
					</div>

					<div class="form-group {if $err.email}has-error{/if}">
						<label for="signup_email" class="col-lg-4 control-label">{t c='global.email'}</label>
						<div class="col-lg-8">
							<input name="email" type="text" class="form-control" value="{$signup.email}" id="signup_email" placeholder="{t c='global.email'}" />
						</div>
					</div>					

					<div class="form-group {if $err.gender}has-error{/if}">
						<label class="col-lg-4 control-label">{t c='global.gender'}</label>
						<div class="col-lg-8">
							<div class="radio">
								<label>
									<input name="gender" type="radio" value="Male" id="signup_gender_male"{if $signup.gender == 'Male'} checked="checked"{/if} />
									{t c='global.male'}
								</label>
							</div>
							<div class="radio">
								<label>
									<input name="gender" type="radio" value="Female" id="signup_gender_female"{if $signup.gender == 'Female'} checked="checked"{/if} />
									{t c='global.female'}
								</label>
							</div>
						</div>
					</div>
					
                    {if $captcha == '1'}
				<!--<div class="form-group {if $err.captcha}has-error{/if}">
						<label for="signup_verification" class="col-lg-4 control-label">{t c='global.verification'}</label>
						<div class="col-lg-8">
							<div class="m-t-5">-->
								{$areyh} 
						<!--</div>
						</div>
					</div>-->
                    {/if}
					
					<div class="form-group">
						<div class="col-lg-8 col-lg-offset-4">
							<div class="checkbox">
								<label>
									<input name="age" type="checkbox" id="signup_age"{if $signup.age == 'on'} checked="checked"{/if} /><span class="{if $err.age}text-danger{/if}"> {t c='signup.certify'}</span>
								</label>
							</div>								
						</div>
						<div class="col-lg-8 col-lg-offset-4">
							<div class="checkbox">
								<label>
									<input name="terms" type="checkbox" id="signup_certify"{if $signup.terms == 'on'} checked="checked"{/if} /> <span class="{if $err.terms}text-danger{/if}"> {t c='signup.terms' u=$baseurl v=$baseurl}</span>
								</label>
							</div>								
						</div>						
					</div>

					<div class="form-group">
						<div class="col-lg-8 col-lg-offset-4">
							<button name="submit_signup" type="submit" class="btn btn-primary">{t c='global.sign_up'}</button>
						</div>
					</div>					
					
			  </fieldset>
			</form>		
		</div>
		</div>
		<div class="col-md-6">
			<div class="well">
				<form class="form-horizontal" name="login_form" id="login_form" method="post" action="{$relative}/login">
				  <fieldset>
					<legend>{t c='login.title' s=$site_name}</legend>
					
						<div class="form-group">
							<label for="login_username" class="col-lg-3 control-label">{t c='global.username'}</label>
							<div class="col-lg-9">
								<input name="username" type="text" class="form-control" value="" id="login_username" placeholder="{t c='global.username'}" />
							</div>
						</div>

						<div class="form-group">
							<label for="login_password" class="col-lg-3 control-label">{t c='global.password'}</label>
							<div class="col-lg-9">
								<input name="password" type="password" class="form-control" value="" id="login_password" placeholder="{t c='global.password'}" />
								<div class="checkbox">
									<label>
										<input name="login_remember" type="checkbox" id="login_remember" /> {t c='global.remember'}
									</label>
								</div>							
							</div>
						</div>

						<div class="form-group">
							<div class="col-lg-9 col-lg-offset-3">
								<a href="{$relative}/lost" rel="nofollow">{t c='global.forgot'}</a>
							</div>
						</div>

						<div class="form-group">
							<div class="col-lg-9 col-lg-offset-3">
								<a href="{$relative}/confirm" rel="nofollow">{t c='global.confirm'}</a>
							</div>
						</div>

						<div class="form-group">
							<div class="col-lg-9 col-lg-offset-3">
								<button name="submit_login" type="submit" class="btn btn-primary">{t c='global.login'}</button>
							</div>
						</div>
						
				  </fieldset>
				</form>		
			</div>
			<div class="well bs-component">
				<legend>{t c='global.what_is' s=$site_name}</legend>
				{include file='static/whatis.tpl'}
			</div>
		</div>
	</div>
</div>