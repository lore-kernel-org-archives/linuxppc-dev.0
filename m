Message-ID: <3C2B4A0A.3E86336E@chinook.com>
Date: Thu, 27 Dec 2001 11:19:22 -0500
From: Peter Desnoyers <pdesnoyers@chinook.com>
MIME-Version: 1.0
To: Liu HongXun-a16975 <a16975@motorola.com>
Cc: linuxppc-embedded <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: The relationship between hhl 2.0 and FEC driver-- the diagnostic
 information
References: <01139FC052A0D411900B00508B9535FC047BC38F@ZCH07EXM04.corp.mot.com>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


This looks like a problem I was having - the new version of the fec
driver fixes it.  I've back-ported the changes to hhl2.0, if you're
interested.

I was only seeing the problem when retrieving large files via FTP - NFS
and TFTP both seemed to work fine.

Liu HongXun-a16975 wrote:
>
> Here is the dump information:
> NETDEV WATCHDOG: eth0: transmit timed out
> eth0: transmit timed out.
> Ring data dump: cur_tx c0453040, dirty_tx c0453040 cur_rx: c0453000
>  tx: 8 buffers
>   c0453040: 9c00 002a 019d8b92
>   c0453048: 9c00 002a 019d8c12

--
.....................................................................
 Peter Desnoyers            (781) 457-1165   pdesnoyers@chinook.com
 Chinook Communications     (617) 661-1979   pjd@fred.cambridge.ma.us
 100 Hayden Ave, Lexington MA 02421

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
