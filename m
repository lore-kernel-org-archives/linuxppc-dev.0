Return-Path: <neko@genesi-usa.com>
Received: from yw-out-2324.google.com (yw-out-2324.google.com [74.125.46.30])
	by ozlabs.org (Postfix) with ESMTP id 640E6DDE1E
	for <linuxppc-dev@ozlabs.org>; Wed, 26 Nov 2008 06:01:20 +1100 (EST)
Received: by yw-out-2324.google.com with SMTP id 5so59100ywh.39
	for <linuxppc-dev@ozlabs.org>; Tue, 25 Nov 2008 11:01:15 -0800 (PST)
Message-ID: <b5e2fc790811251101t1c3b9ca9yaa6d75087190f10f@mail.gmail.com>
Date: Tue, 25 Nov 2008 13:01:15 -0600
From: "Matt Sealey" <matt@genesi-usa.com>
To: "Josh Boyer" <jwboyer@linux.vnet.ibm.com>
Subject: Re: [PATCH/RFC] Add Alternative Log Buffer Support for printk Messages
In-Reply-To: <20081125135519.038abf23@zod.rchland.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_Part_9905_12220231.1227639675360"
References: <1227638045-12862-1-git-send-email-gerickson@nuovations.com>
	<b5e2fc790811251053w507792a1r3673ee2dc7581379@mail.gmail.com>
	<20081125135519.038abf23@zod.rchland.ibm.com>
Cc: linux-embedded@vger.kernel.org, linuxppc-dev@ozlabs.org,
	Stefan Roese <sr@denx.de>, Wolfgang Denx <wd@denx.de>,
	Grant Erickson <gerickson@nuovations.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

------=_Part_9905_12220231.1227639675360
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Tue, Nov 25, 2008 at 12:55 PM, Josh Boyer <jwboyer@linux.vnet.ibm.com>wrote:

> On Tue, 25 Nov 2008 12:53:12 -0600
> "Matt Sealey" <matt@genesi-usa.com> wrote:
>
> > Nitpick, really.. shouldn't the logbuffer location(s) be some device tree
> > property(ies), perhaps something in the
> > /chosen node that U-Boot etc. can then fill out?
>
> I don't think that's a nitpick.  It's a fundamental change in how this
> would all work.  However, I do think you're generally right.
>
> Perhaps not /chosen, but maybe something like /rtas or /firmware, etc.
>
> josh


I think the best place is chosen, with things like stdin, stdout etc. - this
is where you generally go and dump weird little variables which need to be
passed in for early boot. You could consider the log buffer a kind of
stdin/out variation.

I don't think it needs a whole new device tree node just for two memory
locations.. is the support really worth a compatible property, etc. to
differentiate between different operating modes?

-- 
Matt Sealey <matt@genesi-usa.com>
Genesi, Manager, Developer Relations

------=_Part_9905_12220231.1227639675360
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

<br><br><div class="gmail_quote">On Tue, Nov 25, 2008 at 12:55 PM, Josh Boyer <span dir="ltr">&lt;<a href="mailto:jwboyer@linux.vnet.ibm.com">jwboyer@linux.vnet.ibm.com</a>&gt;</span> wrote:<br><blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">
<div class="Ih2E3d">On Tue, 25 Nov 2008 12:53:12 -0600<br>
&quot;Matt Sealey&quot; &lt;<a href="mailto:matt@genesi-usa.com">matt@genesi-usa.com</a>&gt; wrote:<br>
<br>
&gt; Nitpick, really.. shouldn&#39;t the logbuffer location(s) be some device tree<br>
&gt; property(ies), perhaps something in the<br>
&gt; /chosen node that U-Boot etc. can then fill out?<br>
<br>
</div>I don&#39;t think that&#39;s a nitpick. &nbsp;It&#39;s a fundamental change in how this<br>
would all work. &nbsp;However, I do think you&#39;re generally right.<br>
<br>
Perhaps not /chosen, but maybe something like /rtas or /firmware, etc.<br>
<font color="#888888"><br>
josh</font></blockquote><div>&nbsp;</div></div>I think the best place is chosen, with things like stdin, stdout etc. - this is where you generally go and dump weird little variables which need to be passed in for early boot. You could consider the log buffer a kind of stdin/out variation.<br>
<br>I don&#39;t think it needs a whole new device tree node just for two memory locations.. is the support really worth a compatible property, etc. to differentiate between different operating modes?<br clear="all"><br>-- <br>
Matt Sealey &lt;<a href="mailto:matt@genesi-usa.com">matt@genesi-usa.com</a>&gt;<br>Genesi, Manager, Developer Relations<br>

------=_Part_9905_12220231.1227639675360--
