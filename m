Return-Path: <owner-linuxppc-embedded@lists.linuxppc.org>
Message-ID: <20020129163040.43119.qmail@web9704.mail.yahoo.com>
Date: Tue, 29 Jan 2002 08:30:40 -0800 (PST)
From: None Atall <linux_meis@yahoo.com>
Subject: Re: [Linux-ATM-General] Re: ATM driver for 8260 (linux 2.4.x) 
To: Wolfgang Denk <wd@denx.de>
Cc: linuxppc-embedded@lists.linuxppc.org
In-Reply-To: <20020129155511.670E1109D5@denx.denx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


  It was realy cache problem! I had to disable
both caches I,D from the head.S to find that!
Well the receaver works ok with Dcache off....
As I looked from the mpc860sar code, there is a
way to tell linux not to cache specific pages.
But the functions are not compatible with 8260.
Does anyone know how to do that for 8260?

                    Thanks a lot for your time!
                        D. Meidanis


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
