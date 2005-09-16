Return-Path: <JohnsonCheng@qnap.com.tw>
Received: from qnap.com.tw (unknown [211.75.85.27])
	by ozlabs.org (Postfix) with SMTP id 52326682A4
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 16 Sep 2005 13:11:41 +1000 (EST)
From: "JohnsonCheng" <JohnsonCheng@qnap.com.tw>
To: <wd@denx.de>
Date: Fri, 16 Sep 2005 11:11:36 +0800
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
In-Reply-To: <20050915070803.A0EB33529BB@atlas.denx.de>
Message-Id: <20050916031141.52326682A4@ozlabs.org>
Cc: 'linux-ppc-embedded' <linuxppc-embedded@ozlabs.org>
Subject: RE: How to use kerberos in ELDK 
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

1. For ppc-2005-03-07-src, 
   [root]# rpm -iv krb5-1.2.7-14_3.src.rpm
    Warning: user builder does not exist - using root
    Warning: group builder does not exist - using root
    ..................

2. For ppc-2005-03-07
   [root]# rpm -iv krb5-libs-ppc_6xx-1.2.7-14_3.ppc.rpm
    Error: Failed dependencies:
		grep-ppc_6xx is needed by krb5-libs-ppc_6xx-1.2.7-14_3
		sh-utils-ppc_6xx is needed by krb5-libs-ppc_6xx-1.2.7-14_3
   [root]# rpm -iv grep-ppc_6xx-2.5.1-4_1.ppc.rpm
    Preparing packages for installation...
		Package grep-ppc_6xx-2.5.1-4_1 is intended for a ppc
architecture 
		File /bin/egrep freom install of grep-ppc_6xx-2.5.1-4_1
conflicts with file from package grep-2.5.1-26
		................

   Ps: My build machine is x86, therefore, my target ppc board has not
enough space to do this, how can I get krb5 library from ELDK on x86?

Thanks,
Johnson Cheng

-----Original Message-----
From: wd@denx.de [mailto:wd@denx.de] 
Sent: Thursday, September 15, 2005 3:08 PM
To: JohnsonCheng
Cc: linux-ppc-embedded
Subject: Re: How to use kerberos in ELDK 

In message <20050915062857.B598968263@ozlabs.org> you wrote:
> 
> I have loadload ELDK-3.1.1 (ppc-2005-03-07 & ppc-2005-03-07-src), but
> whatever I try it, it doesn't work. 

Can you please provide a specific example command you tried (and make
sure that it's working in a standard Linux environment), and post  it
with a complete list of all output and error messages it produces?


Best regards,

Wolfgang Denk

-- 
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de
Calm down, it's *__only* ones and zeroes.
