Message-ID: <3AAD03B4.6D54C263@intel.com>
Date: Mon, 12 Mar 2001 09:13:24 -0800
From: "Bruno R. Barreyra" <bruno.r.barreyra@intel.com>
MIME-Version: 1.0
To: linuxppc-embedded@lists.linuxppc.org
Subject: Patches for FADS and ppcboot
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Okay, here are the two patches I wrote last week.

The first patch makes the kernel support the FADS board again. I really
hope
this gets included. All it does is reintroduce the config option for the
FADS and
fixes the (abandoned) header file. Would somebody who's got access to
the BK
repository please apply it?

The second patch introduces an option to use the ppcboot bd_info struct
instead
of the specific board one. It won't break anything if it's not selected.
About this
bd_info stuff, shouldn't we just use a more standard definition like
this one instead
of having a separate definition for every board? Or at least have it
come from a
single header file instead of having 10 different copies of it.

--
[]'s Bruno Renato Barreyra
bruno.r.barreyra@ufl.edu
barreyra@ufl.edu


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
