From: Keith Owens <kaos@ocs.com.au>
To: Gabriel Paubert <paubert@iram.es>
cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: Where does ppc define __start___ksymtab? 
In-reply-to: Your message of "Thu, 03 Aug 2000 14:01:44 +0200."
             <Pine.HPX.4.10.10008031350200.9070-100000@gra-ux1.iram.es>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Thu, 03 Aug 2000 22:27:39 +1000
Message-ID: <31770.965305659@ocs3.ocs-net>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Keith Owens wrote
>I'm trying to track down where the extra .bss like data is coming from.
>I will mail the list when I find something.

It turned out to be COMMON.  Adding "*(COMMON)" to the .bss definition
put everything back to the original size.  That just means that
arch/i386/vmlinux.lds is well tuned already, no orphan sections.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
