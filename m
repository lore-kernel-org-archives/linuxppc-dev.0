Date: Fri, 9 Nov 2001 03:04:24 -0600 (CST)
From: "Jeramy B. Smith" <jeramy@penguinppc.org>
To: <linuxppc-dev@lists.linuxppc.org>
Subject: [PATCH] aty128fb.c
Message-ID: <Pine.LNX.4.33.0111090300500.737-100000@penguinppc.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


http://penguinppc.org/projects/jeramy/aty128fb.c.diff

This removes a block of cruft leftover from the iMac days and sets the
default resolution for aty128fb on PPCs to 640x480-60 (ensuring even the
cruddiest of monitors will work).

-jeramy


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
