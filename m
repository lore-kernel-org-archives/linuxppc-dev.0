Message-ID: <3817D447.238914B2@263.net>
Date: Thu, 28 Oct 1999 12:42:47 +0800
From: Wang Yong <wung_y@263.net>
Reply-To: wung_y@263.net
MIME-Version: 1.0
To: linuxppc embedded mail list <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: What's MMU context?
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Dan Malek wrote:
> I intened to use it on the 8xx processors, as they have an address
> space id that allows a TLB optimization so you don't have to
> invalidate the entire TLB on context switches.  I assume the

  is this context contained in TLB entry? if yes, do you mean the
entries
  belong to other processes other the current one should not be replaced
  because it contains the integer ID named context?

  the TLB Entry of PPC401D2 contains lower 8 bit of PID. so it doesn't 
  need to flush all entries out when processing task switch. taking this
  into consider, if context of MMU is not useful any more?

  Thank you.
  Wang


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
