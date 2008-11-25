Return-Path: <neko@genesi-usa.com>
Received: from mail-gx0-f19.google.com (mail-gx0-f19.google.com
	[209.85.217.19]) by ozlabs.org (Postfix) with ESMTP id 53B99DDE06
	for <linuxppc-dev@ozlabs.org>; Wed, 26 Nov 2008 02:19:14 +1100 (EST)
Received: by gxk12 with SMTP id 12so253gxk.9
	for <linuxppc-dev@ozlabs.org>; Tue, 25 Nov 2008 07:19:12 -0800 (PST)
Message-ID: <b5e2fc790811250719h21b2b0e5uc0a249a73458148f@mail.gmail.com>
Date: Tue, 25 Nov 2008 09:19:11 -0600
From: "Matt Sealey" <matt@genesi-usa.com>
To: "Lehmann, Hans (Ritter Elektronik)" <hans.lehmann@ritter-elektronik.de>
Subject: Re: [PATCH]: [MPC5200] Add ATA DMA support
In-Reply-To: <633A55242A59C7488FAAF5A6850929984B814A@SRVEXC01.sts.saurer.vpn>
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_Part_6393_22614311.1227626351254"
References: <633A55242A59C7488FAAF5A6850929984B814A@SRVEXC01.sts.saurer.vpn>
Cc: Tim Yamin <plasm@roo.me.uk>, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

------=_Part_6393_22614311.1227626351254
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Tue, Nov 25, 2008 at 8:45 AM, Lehmann, Hans (Ritter Elektronik) <
hans.lehmann@ritter-elektronik.de> wrote:

> Tim, Grant,
>
> just an info.
>
> Very often the Bestcomm-FEC crashed without any error logs if I initiate a
> transaction over FEC and save the file to disk (I rememeber I have read
> something like that). A restart of FEC don't work.
> But no I figured out, if I connect to the other ethernet port of our board
> (natsemi) the FEC will awake to life again, if I initiate a new transaction
> over natsemi. This seems a little oddly to me.
>

Hi guys,

We tried to get the SUSE guys to push the patch into openSUSE 11.1 release
and the tests came back negative here too with regards to FEC support; for
some odd reason, it does this;

https://bugzilla.novell.com/show_bug.cgi?id=445856#c10

There is some weird interaction here, but I can't imagine what it might be.
Tim, did you ever see any ethernet problems like this?

-- 
Matt Sealey <matt@genesi-usa.com>
Genesi, Manager, Developer Relations

------=_Part_6393_22614311.1227626351254
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

<br><br><div class="gmail_quote">On Tue, Nov 25, 2008 at 8:45 AM, Lehmann, Hans (Ritter Elektronik) <span dir="ltr">&lt;<a href="mailto:hans.lehmann@ritter-elektronik.de">hans.lehmann@ritter-elektronik.de</a>&gt;</span> wrote:<br>
<blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">Tim, Grant,<br>
<br>
just an info.<br>
<br>
Very often the Bestcomm-FEC crashed without any error logs if I initiate a transaction over FEC and save the file to disk (I rememeber I have read something like that). A restart of FEC don&#39;t work.<br>
But no I figured out, if I connect to the other ethernet port of our board (natsemi) the FEC will awake to life again, if I initiate a new transaction over natsemi. This seems a little oddly to me.<br>
</blockquote><div><br>Hi guys,<br><br>We tried to get the SUSE guys to push the patch into openSUSE 11.1 release and the tests came back negative here too with regards to FEC support; for some odd reason, it does this;<br>
<br><a href="https://bugzilla.novell.com/show_bug.cgi?id=445856#c10">https://bugzilla.novell.com/show_bug.cgi?id=445856#c10</a> <br></div></div><br>There is some weird interaction here, but I can&#39;t imagine what it might be. Tim, did you ever see any ethernet problems like this?<br>
<br>-- <br>Matt Sealey &lt;<a href="mailto:matt@genesi-usa.com">matt@genesi-usa.com</a>&gt;<br>Genesi, Manager, Developer Relations<br>

------=_Part_6393_22614311.1227626351254--
