Message-Id: <200210031539.KAA38110@popmail.austin.ibm.com>
Content-Type: text/plain;
  charset="iso-8859-1"
From: Hollis Blanchard <hollis@austin.ibm.com>
To: linuxppc-embedded@lists.linuxppc.org
Subject: Re: Anyone built a PPC cross compiler on debian?
Date: Thu, 3 Oct 2002 10:42:55 -0500
References: <20021003035445.GA2987@dd.nec.com.au>
In-Reply-To: <20021003035445.GA2987@dd.nec.com.au>
MIME-Version: 1.0
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Wednesday 02 October 2002 22:54, Erik Christiansen wrote:
>    Penguinppc.org's "Cross Development mini-howto for PPC Linux" failed
> to build on my x86 debian woody host, due to an autoconf bug. (Thanks to
> Hollis Blanchard for identifying this.)
[snip]
>    While I toss a coin to choose between trying to build binutils in a
> manual hack, or dealing with RPMs on debian, is there another option
> that should be considered?

Don't misunderstand... yes there's a configure.in bug, but it's only
triggered by you missing something you need (this is frequently i18n stuff).
So another option for you is to install the missing package.

-Hollis

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
