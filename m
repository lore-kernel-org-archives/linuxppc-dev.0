Return-Path: <owner-linuxppc-dev@lists.linuxppc.org>
Content-Type: text/plain;
  charset="iso-8859-1"
From: "Kevin B. Hendricks" <khendricks@ivey.uwo.ca>
To: "Michael R. Zucca" <mrz5149@acm.org>,
	David Edelsohn <dje@watson.ibm.com>
Subject: Re: fetch_and_add() available on PPC Linux?Hi,
Date: Thu, 6 Dec 2001 09:07:57 -0500
Cc: linuxppc-dev@lists.linuxppc.org
References: <gM988793884351.18059@mail1.hongkong.com> <l03130301b8351d769a73@[192.168.1.2]>
In-Reply-To: <l03130301b8351d769a73@[192.168.1.2]>
MIME-Version: 1.0
Message-Id: <20011206140445.TQHJ17034.tomts10-srv.bellnexxia.net@there>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi,

> See the PPC manual for the lock granule size. I forget what it is off
> the top of my head.

I think it is the same as the cache line size (32 bytes for most ppc
machines but defintely that cache line size changes for some
implementations (so go with at least 32 bytes and you should be safe).

Kevin

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
