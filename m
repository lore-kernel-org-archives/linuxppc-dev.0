Message-ID: <3C214290.D6D1B53A@carts.com>
Date: Wed, 19 Dec 2001 17:44:48 -0800
From: Kevin Fry <kevin@carts.com>
MIME-Version: 1.0
To: linuxppc-embedded@lists.linuxppc.org
Subject: allocating non-cacheable memory
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


What is the best way to allocate some non-cacheable memory for I/O use?
Right now we are going to setup a BAT table with a non-cacheable memory
region and use that for all I/O, but does linux have a nice neat
function to grab a page and set it up non-cacheable for us?
I was reading in the archives that the #define PAGE_NOCACHE doesn't
work.

thanks!

Kevin


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
