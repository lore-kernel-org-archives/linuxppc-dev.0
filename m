Message-ID: <383AC15A.1D5EAFE2@dalim.de>
Date: Tue, 23 Nov 1999 17:31:22 +0100
From: Stephane GEORGES <sg@dalim.de>
MIME-Version: 1.0
To: Andreas Tobler <a.tobler@schweiz.ch>
CC: linuxppc-dev@lists.linuxppc.org
Subject: Re: R_PPC_REL24 relocation out of range
References: <A5D247E9DC04C08EC1256832004AFECD.004AFF0FC1256832@kehl.dalim.de>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Andreas Tobler wrote:

> Which version of binutils are you working with? Maybe a newer version
> helps?
> http://dev.linuxppc.org/pub/users/fsirl/R5/RPMS/ppc/binutils-2.9.5.0.14-0a.
> ppc.rpm

I downloaded the binutils-2.9.5.0.14-0a
NOW, most of my plugins are dlopen'ed correctly. But there are still some
of them with which I have the same error message.

I tried the command

ldd -r ..../plugin.so.1.0 and they do not seem to have unresolved symbol.

What do you think it is ?

--

/====================================================================/|
| Stephane GEORGES                     |                             ||
| DALiM SOFTWARE GmbH      R&D         |    Tel: +49 7851 9196 40    ||
| Strassburger Str.6                   |    Fax: +49 7851 7357 6     ||
| D-77696                              |                             ||
| Kehl-Sundheim (Germany)              |    E-mail: sg@dalim.de      ||
|____________________________________________________________________|/


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
