Return-Path: <owner-linuxppc-embedded@lists.linuxppc.org>
Message-ID: <20040426164104.21828.qmail@web41503.mail.yahoo.com>
Date: Mon, 26 Apr 2004 09:41:04 -0700 (PDT)
From: bhupinder sahran <bhup_sah@yahoo.com>
Subject: High resolution timer in driver
To: linuxppc-embedded@lists.linuxppc.org
Cc: linuxppc-embedded@lists.linuxppc.org
In-Reply-To: <15882.33210.146613.132083@argo.ozlabs.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi guys

I am writting a device driver. I have a requirement
that i need a timer base interrupt serive routine
which shall be called 1024 times in a second. But my
understanding is saying that i can call it only once
in a second through generic linux timer.


Can anyone through some pointer here.

Thanx and regards
Bhupi




Yahoo! Photos: High-quality 4x6 digital prints for 25¢
http://photos.yahoo.com/ph/print_splash

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
