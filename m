Return-Path: <owner-linuxppc-embedded@lists.linuxppc.org>
Message-ID: <20030520071839.36639.qmail@web9708.mail.yahoo.com>
Date: Tue, 20 May 2003 00:18:39 -0700 (PDT)
From: None Atall <linux_meis@yahoo.com>
Subject: Early malloc function (MPC826x) ??
To: linuxppc-embedded@lists.linuxppc.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


 Hi everybody,
Is there a function that I can call (for memory
allocation (just like kmalloc)) but in the early init
stage inside "m8260_cpm_dpalloc" or "m8260_cpm_reset"?
 I want to implement "m8260_cpm_dpalloc" with linked
lists, so that I can implement "m8260_cpm_dpfree" as
well. But of course, with kmalloc( ,GFP_KERNEL), the
system will not boot :))

                              Thanks
                                Dimitris.


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
