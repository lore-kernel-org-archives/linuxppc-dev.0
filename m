Return-Path: <owner-linuxppc-embedded@lists.linuxppc.org>
To: "Embedded Linux PPC list" <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: Linux is not reliable enough?
References: <KCEOLLHGFJIAFNAMGACHMEMODPAA.k@kcomputing.com>
From: Linh Dang <linh@home.earth>
Date: Fri, 23 Jul 2004 23:02:15 -0400
In-Reply-To: <KCEOLLHGFJIAFNAMGACHMEMODPAA.k@kcomputing.com> (Kevin P.
 Dankwardt's message of "Fri, 23 Jul 2004 17:06:58 -0400")
Message-ID: <wn5pt6mw1jc.fsf@linhd-2.ca.nortel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Well, X server doesn't run in the same vm space as the
kernel. however, on my PC, X is the thing that would most likely to
put the system into an unusable state (frozen keyboard, mouse and
screen).

QNX's drivers run in their own process space but they still have
direct access to the hardware. A driver can screw up the hw regardless
whatever vm-sandbox in which it run.


my 0.02$

--
Linh Dang

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
