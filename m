Message-ID: <3FD5F421.2070100@kegel.com>
Date: Tue, 09 Dec 2003 08:11:13 -0800
From: Dan Kegel <dank@kegel.com>
MIME-Version: 1.0
To: hyding <nari_dhy@nari-china.com>
Cc: linuxppc-embed <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: cross compile software package
References: <00f701c3be5c$39d2a280$4844900a@hydingnb1>
In-Reply-To: <00f701c3be5c$39d2a280$4844900a@hydingnb1>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


hyding wrote:
> hi,all
>     I have built the cross-compile tools chain for ppc 405,
> gcc-3.3.1-binutils-2.14-glibc-2.3.2.Now i want to use it to compile some
> software packages making up of a root fs. I compiled findutils-4.1.20
> successfully, but failed to compile other packages such as coreutils,
> vim,etc.
>     Could someone give me some hints about where to download the
> packages that are able to be cross-compiled. Which version of the
> cross-compile tools is better?

Have a look at http://ptxdist.sf.net
It knows how to cross-compile lots of packages.
- Dan


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
