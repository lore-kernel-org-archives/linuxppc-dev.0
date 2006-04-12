Return-Path: <jschopp@austin.ibm.com>
Received: from e34.co.us.ibm.com (e34.co.us.ibm.com [32.97.110.152])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e34.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 658EE67B91
	for <linuxppc-dev@ozlabs.org>; Wed, 12 Apr 2006 21:28:42 +1000 (EST)
Received: from westrelay02.boulder.ibm.com (westrelay02.boulder.ibm.com
	[9.17.195.11])
	by e34.co.us.ibm.com (8.12.11.20060308/8.12.11) with ESMTP id
	k3CBSdxT002100
	for <linuxppc-dev@ozlabs.org>; Wed, 12 Apr 2006 07:28:39 -0400
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
	by westrelay02.boulder.ibm.com (8.12.10/NCO/VER6.8) with ESMTP id
	k3CBPAZu246206
	for <linuxppc-dev@ozlabs.org>; Wed, 12 Apr 2006 05:25:10 -0600
Received: from d03av03.boulder.ibm.com (loopback [127.0.0.1])
	by d03av03.boulder.ibm.com (8.12.11/8.13.3) with ESMTP id
	k3CBSdAL012165
	for <linuxppc-dev@ozlabs.org>; Wed, 12 Apr 2006 05:28:39 -0600
Message-ID: <443CE464.6040209@austin.ibm.com>
Date: Wed, 12 Apr 2006 06:28:36 -0500
From: jschopp <jschopp@austin.ibm.com>
MIME-Version: 1.0
To: Sai prasanna <saiprasannasp@yahoo.com>
Subject: Re: BFD 2.16.1 assertion fail
References: <20060412073814.39382.qmail@web54313.mail.yahoo.com>
In-Reply-To: <20060412073814.39382.qmail@web54313.mail.yahoo.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

If you just want a working cross compiler these tend to be pretty good:
http://developer.osdl.org/dev/plm/cross_compile/

Or if you insist on doing your own crosstool is a very good idea:
http://www.kegel.com/crosstool/

-Joel

Sai prasanna wrote:
> 
>     Date: Wed, 12 Apr 2006 00:04:59 -0700 (PDT)
>     From: Sai prasanna <saiprasannasp@yahoo.com>
>     Subject: BFD 2.16.1 assertion fail
>     To: linux project group <linux_projects_2006@yahoogroups.com>
>     CC: saiprasannasp@yahoo.com
> 
>     Hi All,
> 
>     I Have been trying to build across compiler for power-ppc-linux-gnu
>     I have succesfully installed binutils-2.16.1, first phase gcc-4.0.3,
>     glibc-2.3.6 and then when i finally tried to install the final gcc
>     ima getting eror such as
> 
>     /home/foo/build-install/powerpc-ppc-linux-gnu/bin/ld: BFD 2.16.1
>     assertion fail../../binutils-2.16.1/bfd/elf32-ppc.c:5397
>     collect2: ld returned 1 exit status
>     make[3]: *** [libmudflap.la] Error 1
>     make[3]: Leaving directory
>     `/home/foo/build-gcc/powerpc-ppc-linux-gnu/libmudflap'
>     make[2]: *** [all-recursive] Error 1
>     make[2]: Leaving directory
>     `/home/foo/build-gcc/powerpc-ppc-linux-gnu/libmudflap'
>     make[1]: *** [all] Error 2
>     make[1]: Leaving directory
>     `/home/foo/build-gcc/powerpc-ppc-linux-gnu/libmudflap'
>     make: *** [all-target-libmudflap] Error 2
> 
>     I have used the following gcc configuration opitons
> 
>     [root@localhost build-gcc]# ../gcc-4.0.3/configure
>     --host=i686-pc-linux-gnu --target=powerpc-ppc-linux-gnu
>     --prefix=/home/foo/build-install --enable-languages=c,c++
> 
>     Some one please help me with this.
> 
>     Regards,
>     Sai     
> 
> 
>     Sai Prasanna.S,
>     Department Of ComputerScience,
>     University Of Madras,
>     Chennai.
> 
>     Ph: 9940357430
>     Email: saiprasannasp@yahoo.com
>     ------------------------------------------------------------------------
>     Love cheap thrills? Enjoy PC-to-Phone calls to 30+ countries
>     <http://us.rd.yahoo.com/mail_us/taglines/postman9/*http://us.rd.yahoo.com/evt=39666/*http://beta.messenger.yahoo.com/>
>     for just 2�/min with Yahoo! Messenger with Voice.
> 
> 
> ------------------------------------------------------------------------
> Yahoo! Messenger with Voice. 
> <http://us.rd.yahoo.com/mail_us/taglines/postman3/*http://us.rd.yahoo.com/evt=39666/*http://beta.messenger.yahoo.com> 
> PC-to-Phone calls for ridiculously low rates.
> 
> 
> ------------------------------------------------------------------------
> 
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-dev
