From: Keith Owens <kaos@ocs.com.au>
To: Geert Uytterhoeven <geert@linux-m68k.org>
cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: Where does ppc define __start___ksymtab? 
In-reply-to: Your message of "Wed, 02 Aug 2000 22:18:08 +0200."
             <Pine.LNX.4.10.10008022216520.833-100000@cassiopeia.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Thu, 03 Aug 2000 21:40:45 +1000
Message-ID: <31440.965302845@ocs3.ocs-net>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Wed, 2 Aug 2000 22:18:08 +0200 (CEST),
Geert Uytterhoeven <geert@linux-m68k.org> wrote:
>On Tue, 1 Aug 2000, Keith Owens wrote:
>> Please cc: kaos@ocs.com.au on replies, I am not on this list.
>>
>> I have been trying to find where ppc defines __start___ksymtab and
>> __stop___ksymtab symbols.
>
>I'm no gcc linkscript expert, but doesn't the absence of __ksymtab stuff in
>vmlinux.lds simply mean that gcc can put stuff for section __ksymtab wherever
>it wants in the final object file?

Placement was not the problem.  It was the "magic" definition of
__start___ksymtab and __stop___ksymtab that had me baffled.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
