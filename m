Return-Path: <armin.schindler@sysgo.com>
Date: Tue, 26 Sep 2006 09:21:39 +0200 (CEST)
From: Armin Schindler <armin.schindler@sysgo.com>
Sender: acs@sysgo.com
To: Iwan Koenig <iwankoenig@yahoo.de>
Subject: Re: Asterisk on Embedded Linux
In-Reply-To: <20060926064451.71706.qmail@web26012.mail.ukl.yahoo.com>
Message-ID: <Pine.LNX.4.61.0609260917250.27192@acs.sysgo.com>
References: <20060926064451.71706.qmail@web26012.mail.ukl.yahoo.com>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="380373515-63631276-1159255299=:27192"
Cc: Linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--380373515-63631276-1159255299=:27192
Content-Type: TEXT/PLAIN; charset=iso-8859-1; format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Tue, 26 Sep 2006, Iwan Koenig wrote:
> Does anyone known how to compile Asterisk for a
> powerpc-processor?
> I have tryed:
> ./configure --target=3Dpowerpc-linux
> --host=3Dpowerpc-604-linux-gnu --prefix=3D/opt/packages
> And it gives following error:
> /root/pwlib/include/ptlib.h... configure: error:
> cannot check for file existence when cross compiling
>
> Ok! I see that it is trying to find the PWLIB-Library.
> Also, i have tryed to compile the pwlib.
> But it didn't work :(. For PWLIB i need the OpenLDAP,
> and when i have compiled the OpenLDAP, than needs
> PWLIB other packages.......
> Also, have anyone ideas, how to compile Asterisk f=FCr a
> powerpc-processor with another way?

Which version of Asterisk do you want to use? I have version 1.2.X=20
cross-compiled, but asterisk sources need to be patched. E.g. the
host tools ar and ranlib are hardcoded in Makefiles.
(I don't know the status for version 1.4).

Armin

--=20
Armin Schindler <armin.schindler AT sysgo.com>
SYSGO AG                      Embedded and Real-Time Software
www.sysgo.com | www.elinos.com | www.pikeos.com | www.osek.de

--380373515-63631276-1159255299=:27192--
