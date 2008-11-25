Return-Path: <neko@genesi-usa.com>
Received: from yw-out-2324.google.com (yw-out-2324.google.com [74.125.46.30])
	by ozlabs.org (Postfix) with ESMTP id 7D6B3DDD0B
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 26 Nov 2008 06:45:03 +1100 (EST)
Received: by yw-out-2324.google.com with SMTP id 5so70883ywh.39
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 25 Nov 2008 11:45:02 -0800 (PST)
Message-ID: <b5e2fc790811251145r396d4528m23e5743e2fef9142@mail.gmail.com>
Date: Tue, 25 Nov 2008 13:45:01 -0600
From: "Matt Sealey" <matt@genesi-usa.com>
To: "Thomas Johnson" <TMJohnson@fyldemicro.com>
Subject: Re: SRAM
In-Reply-To: <02296E583CC11C4D9365985B761F1DDE73613B@www.fyldemicro.co.uk>
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_Part_15641_30668592.1227642301818"
References: <AclNmotrM/DrqMJlQRiP+5XNFUf3TA==>
	<02296E583CC11C4D9365985B761F1DDE73613B@www.fyldemicro.co.uk>
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

------=_Part_15641_30668592.1227642301818
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Is it memory mapped somewhere? If it is you can emulate an MTD using the
"slram" driver.

Then you can just use whatever you like on top - JFFS2 or something that
thinks it's going to be on flash or something, ext2 if you're nuts. But,
seriously, with slram you *can* go nuts.

On Sun, Nov 23, 2008 at 12:37 PM, Thomas Johnson
<TMJohnson@fyldemicro.com>wrote:

>  We have a new PPC based board which includes some SRAM (actually Everspin
> MRAM).
>
> I can't work out the best way to mount this device or what filing system to
> run on it, any advice ?
>
> Thanks
>
> TJ
>
> _______________________________________________
> Linuxppc-embedded mailing list
> Linuxppc-embedded@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-embedded
>



-- 
Matt Sealey <matt@genesi-usa.com>
Genesi, Manager, Developer Relations

------=_Part_15641_30668592.1227642301818
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Is it memory mapped somewhere? If it is you can emulate an MTD using the &quot;slram&quot; driver.<br><br>Then you can just use whatever you like on top - JFFS2 or something that thinks it&#39;s going to be on flash or something, ext2 if you&#39;re nuts. But, seriously, with slram you *can* go nuts.<br>
<br><div class="gmail_quote">On Sun, Nov 23, 2008 at 12:37 PM, Thomas Johnson <span dir="ltr">&lt;<a href="mailto:TMJohnson@fyldemicro.com">TMJohnson@fyldemicro.com</a>&gt;</span> wrote:<br><blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">




<div>
<div><span><font face="Arial" size="2">We have a new PPC 
based board which includes&nbsp;some SRAM (actually Everspin 
MRAM).</font></span></div>
<div><span><font face="Arial" size="2"></font></span>&nbsp;</div>
<div><span><font face="Arial" size="2">I can&#39;t work out the 
best way to mount this&nbsp;device or what filing system to run on it, any 
advice ?</font></span></div>
<div><span><font face="Arial" size="2"></font></span>&nbsp;</div>
<div><span><font face="Arial" size="2">Thanks 
</font></span></div>
<div><span><font face="Arial" size="2"></font></span>&nbsp;</div><font color="#888888">
<div><span><font face="Arial" size="2">TJ</font></span></div></font></div>
<br>_______________________________________________<br>
Linuxppc-embedded mailing list<br>
<a href="mailto:Linuxppc-embedded@ozlabs.org">Linuxppc-embedded@ozlabs.org</a><br>
<a href="https://ozlabs.org/mailman/listinfo/linuxppc-embedded" target="_blank">https://ozlabs.org/mailman/listinfo/linuxppc-embedded</a><br></blockquote></div><br><br clear="all"><br>-- <br>Matt Sealey &lt;<a href="mailto:matt@genesi-usa.com">matt@genesi-usa.com</a>&gt;<br>
Genesi, Manager, Developer Relations<br>

------=_Part_15641_30668592.1227642301818--
