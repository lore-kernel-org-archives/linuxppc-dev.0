Return-Path: <jcrigby@gmail.com>
Message-ID: <4b73d43f0707091635o3ff98713raae9bd914007d9f3@mail.gmail.com>
Date: Mon, 9 Jul 2007 17:35:58 -0600
From: "John Rigby" <jcrigby@gmail.com>
To: "Grant Likely" <grant.likely@secretlab.ca>
Subject: Re: [PATCH] Add USB support to mpc8349-mitx board port
In-Reply-To: <fa686aa40707091003n45870ccdn8c9a3629cf19cf77@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_Part_184567_9099669.1184024158185"
References: <20070706222909.19943.39455.stgit@trillian.secretlab.ca>
	<200707070148.20526.arnd@arndb.de>
	<fa686aa40707062246j71a347acje8559b7b6be9d38b@mail.gmail.com>
	<4b73d43f0707071734yeedd7e6g53101d45fbec899e@mail.gmail.com>
	<fa686aa40707071748g7f00f4c7jb761cceb7d72456d@mail.gmail.com>
	<4b73d43f0707082055y2b96fa53td55d6b381b6fb0ef@mail.gmail.com>
	<fa686aa40707091003n45870ccdn8c9a3629cf19cf77@mail.gmail.com>
Cc: Linuxppc-embedded <Linuxppc-embedded@ozlabs.org>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

------=_Part_184567_9099669.1184024158185
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

I'm just saying that an argument can be made that having all the OF to
non-OF
glue in one place is better than having dual bindings in every driver.

If you count ugliness in terms of file count the fsl_soc.c solution
gets a score of 1 and the dual binding solution gets an score of N.
Where N is the number of drivers.

John

On 7/9/07, Grant Likely <grant.likely@secretlab.ca> wrote:
>
> On 7/8/07, John Rigby <jcrigby@gmail.com> wrote:
> > I see your point, I agree the two layers of glue is bad.  But this means
> > the double code is spread across many drivers instead of being in one
> > place (fsl_soc.c).
>
> ???  I don't understand what you mean.  Are you saying that it's
> better to have all the OF bindings in one place (fsl_soc.c) instead of
> with each individual driver?
>
> Cheers,
> g.
>
>
> --
> Grant Likely, B.Sc., P.Eng.
> Secret Lab Technologies Ltd.
> grant.likely@secretlab.ca
> (403) 399-0195
>

------=_Part_184567_9099669.1184024158185
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

I&#39;m just saying that an argument can be made that having all the OF to non-OF<br>glue in one place is better than having dual bindings in every driver.<br><br>If you count ugliness in terms of file count the fsl_soc.c solution
<br>gets a score of 1 and the dual binding solution gets an score of N.<br>Where N is the number of drivers.<br><br>John<br><br><div><span class="gmail_quote">On 7/9/07, <b class="gmail_sendername">Grant Likely</b> &lt;<a href="mailto:grant.likely@secretlab.ca">
grant.likely@secretlab.ca</a>&gt; wrote:</span><blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">On 7/8/07, John Rigby &lt;<a href="mailto:jcrigby@gmail.com">
jcrigby@gmail.com</a>&gt; wrote:<br>&gt; I see your point, I agree the two layers of glue is bad.&nbsp;&nbsp;But this means<br>&gt; the double code is spread across many drivers instead of being in one<br>&gt; place (fsl_soc.c).<br>
<br>???&nbsp;&nbsp;I don&#39;t understand what you mean.&nbsp;&nbsp;Are you saying that it&#39;s<br>better to have all the OF bindings in one place (fsl_soc.c) instead of<br>with each individual driver?<br><br>Cheers,<br>g.<br><br><br>--<br>
Grant Likely, B.Sc., P.Eng.<br>Secret Lab Technologies Ltd.<br><a href="mailto:grant.likely@secretlab.ca">grant.likely@secretlab.ca</a><br>(403) 399-0195<br></blockquote></div><br>

------=_Part_184567_9099669.1184024158185--
