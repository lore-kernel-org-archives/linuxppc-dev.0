Date: Thu, 28 Jun 2001 13:10:43 +1000
From: Steven Hanley <sjh@svana.org>
To: Linux PPC Dev <linuxppc-dev@lists.linuxppc.org>
Subject: Re: addresses in xmon trace output?
Message-ID: <20010628131043.A913@wibble.net>
Reply-To: Steven Hanley <sjh@wibble.net>
References: <20010628120346.A627@wibble.net> <20010627191103.A27680@nevyn.them.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20010627191103.A27680@nevyn.them.org>; from dmj+@andrew.cmu.edu on Wed, Jun 27, 2001 at 07:11:03PM -0700
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Wed, Jun 27, 2001 at 07:11:03PM -0700, Daniel Jacobowitz wrote:
> They're addresses all right.  System.map lists the beginning of each
> function; those addresses will be somewhere in the middle.  It's
> sorted; find the closest match before each.

okay, that was easy, although the first address doesnt seem to be in the map
anywhere, maybe I copied it down wrong I suppose.

[13:04:08] 30 shiva sjh ~>./findinsmap.pl /boot/System.map-2.4.6-pre3
c67b2098 c00e1bd8 c00e1080 c011f9df c00de590 c00de7ec c003b6a4 c0003b3c
Addr: c00e1bd8 A: c00e1aa8 B: c00e1cb0 Function: c00e1aa8 T alloc_skb
Addr: c00e1080 A: c00e1004 B: c00e1170 Function: c00e1004 T sock_alloc_send_skb
Addr: c011f9df A: c011f8b4 B: c011fc74 Function: c011f8b4 t unix_stream_sendmsg
Addr: c00de590 A: c00de4f4 B: c00de5c0 Function: c00de4f4 T sock_sendmsg
Addr: c00de7ec A: c00de758 B: c00de7fc Function: c00de758 t sock_write
Addr: c003b6a4 A: c003b5dc B: c003b6f0 Function: c003b5dc T sys_write
Addr: c0003b3c A: c0003b3c B: c0003bf0 Function: c0003b3c T ret_from_syscall_1

        See You
            Steve

--
sjh@wibble.net http://wibble.net/~sjh/
Look Up In The Sky
   Is it a bird?  No
      Is it a plane?  No
         Is it a small blue banana?
YES

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
