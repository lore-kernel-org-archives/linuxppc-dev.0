Return-Path: <pochini@shiny.it>
Message-ID: <XFMail.20051021091908.pochini@shiny.it>
Content-Type: text/plain; charset=us-ascii
MIME-Version: 1.0
In-Reply-To: <17221.45591.341270.888791@cargo.ozlabs.ibm.com>
Date: Fri, 21 Oct 2005 09:19:08 +0200 (CEST)
Sender: pochini@agnus.shiny.it
From: Giuliano Pochini <pochini@shiny.it>
To: Paul Mackerras <paulus@samba.org>
Cc: linuxppc-dev@ozlabs.org, linuxppc64-dev@ozlabs.org
Subject: Re: Starting the arch/powerpc merge
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On 06-Oct-2005 Paul Mackerras wrote:

>> Out of curiosity, is there any advantage in using a 32 bits
>> kernel on ppc64 over a 64 bits kernel ?  Speed ?  Complexity ?
>> Compatibility ?  Memory ?
>
> Not really.  The main thing in the past has been that DRI with 32-bit
> X server and clients would work with a 32-bit kernel but not a 64-bit
> kernel, but that's fixed now.  A 64-bit kernel is faster on most
> lmbench tests.  I guess a 32-bit kernel might end up a little smaller,
> but that's the only possible advantage I can think of.

And 32<->64 bits compatibility layer for 32bits apps is not needed,
so maybe they run a bit faster. Well, at this point IMHO 32-on-64
support may be dropped without regrets. Spending time for an useless
thing is - uhm - useless.


> Oops, sorry, mail system breakage here...

My mail wasn't important anyway :))


--
Giuliano.
