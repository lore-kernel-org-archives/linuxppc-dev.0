Return-Path: <wd@denx.de>
Received: from mailout01.sul.t-online.com (mailout01.sul.t-online.com
	[194.25.134.80]) by ozlabs.org (Postfix) with ESMTP id AE24F6829F
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 16 Sep 2005 16:33:18 +1000 (EST)
To: "JohnsonCheng" <JohnsonCheng@qnap.com.tw>
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Fri, 16 Sep 2005 11:11:36 +0800."
	<20050916031236.E521942DDD@denx.de>
Date: Fri, 16 Sep 2005 08:32:38 +0200
Sender: wd@denx.de
Message-Id: <20050916063238.24A5B352B7B@atlas.denx.de>
Cc: 'linux-ppc-embedded' <linuxppc-embedded@ozlabs.org>
Subject: Re: How to use kerberos in ELDK 
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

In message <20050916031236.E521942DDD@denx.de> you wrote:
> 1. For ppc-2005-03-07-src, 
>    [root]# rpm -iv krb5-1.2.7-14_3.src.rpm

There is no need to be root to install the ELDK or ELDK packages.

Also, you should read (and  follow)  the  documentation;  the  manual
explains  in  deatil that you have to use the ELLDK's own RPM-tool to
install  (or  remove)  ELDK   packets.   For   details   please   see
http://www.denx.de/twiki/bin/view/DULG/ELDKIndividualPackages

> 2. For ppc-2005-03-07
>    [root]# rpm -iv krb5-libs-ppc_6xx-1.2.7-14_3.ppc.rpm
>     Error: Failed dependencies:
> 		grep-ppc_6xx is needed by krb5-libs-ppc_6xx-1.2.7-14_3
> 		sh-utils-ppc_6xx is needed by krb5-libs-ppc_6xx-1.2.7-14_3
>    [root]# rpm -iv grep-ppc_6xx-2.5.1-4_1.ppc.rpm
>     Preparing packages for installation...
> 		Package grep-ppc_6xx-2.5.1-4_1 is intended for a ppc
> architecture 
> 		File /bin/egrep freom install of grep-ppc_6xx-2.5.1-4_1
> conflicts with file from package grep-2.5.1-26

All these are consequences of your wrong commands.

You must use "${CROSS_COMPILE}rpm" instead.

>    Ps: My build machine is x86, therefore, my target ppc board has not
> enough space to do this, how can I get krb5 library from ELDK on x86?

Actually these get installed by default when you install the ELDK:

	-> ppc_8xx-rpm -q krb5-devel krb5-libs
	krb5-devel-ppc_8xx-1.2.7-14_3
	krb5-libs-ppc_8xx-1.2.7-14_3


Best regards,

Wolfgang Denk

-- 
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de
Houston, Tranquillity Base here.  The Eagle has landed.
                                                    -- Neil Armstrong
