Message-ID: <3BA65C71.C9E8B5CF@chinook.com>
Date: Mon, 17 Sep 2001 16:26:25 -0400
From: Peter Desnoyers <pdesnoyers@chinook.com>
MIME-Version: 1.0
To: "Boerner, Brian" <bmb@pirus.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: Walnut Crash
References: <200109171432.JAA27268@lists.linuxppc.org>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


"Boerner, Brian" wrote:
>
> 2. Kernel panic: Attempted to kill init!
>    Has init even started yet??? I thought init was a process started
>    from the root filesystem.

If you get a bus error during kernel boot, it gets delivered to process
1 once it starts up, causing a delayed "Attempting to kill init!"
message.  Or something like that.  Basically, ignore anything that
happens after the oops.

--
.....................................................................
 Peter Desnoyers            (781) 457-1165   pdesnoyers@chinook.com
 Chinook Communications     (617) 661-1979   pjd@fred.cambridge.ma.us
 100 Hayden Ave, Lexington MA 02421

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
