Message-ID: <001b01c3e70d$3654e3f0$0100a8c0@pc002>
From: "Ale ppc" <aleppcrossi@libero.it>
To: <arunkumar@actinium.org>
Cc: "linuxppc-embedded" <linuxppc-embedded@lists.linuxppc.org>
References: <200401300952.AA178585798@actinium.org>
Subject: Re: Problem in Cross compiling Pwlib for LINUX
Date: Fri, 30 Jan 2004 09:43:57 +0100
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi Arunkumar,


I have changed ptbuildopts.mak in this way :

    ENDLDLIBS += -lpthread -lcrypto -lresolv

    HAS_OPENSSL =
    HAS_OPENLDAP =
    HAS_EXPAT =
    HAS_SDL =
    TRY_1394AVC =
    TRY_1394DC =

and in ptbuildopts.h undefine :

    #define P_LDAP 1
    #define P_EXPAT 1
    #define P_SSL 1
    #define P_USE_SYSTEM_SWAB 1

I have erased the default library lber, dap, dap_r, ssl, expat, dl because I
did not need of them.
In fact then I have well cross-compiled openH323 src file.
To test my board I have used the callgen323 (v 1.2.6) application program
that came from openh323 sourceforge site.
I don't test other application prg.

Because I work fine with Motorola MPC82xx and ARM7TDMI tecnology, and we are
interested to port H323 on uClinux for ARM7 too. But we have found several
problems using siap-uClinx-xx cross-compile tool. If you know about related
problem can give me a search path to solve the question?

Regards,
Alessandro


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
