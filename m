Date: Wed, 24 Oct 2001 15:46:33 -0700
From: Okehee Goh <ogoh@asu.edu>
Subject: MMU in MBX860
To: linuxppc-embedded@lists.linuxppc.org
Message-id: <CPEELCODKANPCLBCAGOFKEBKCAAA.ogoh@asu.edu>
MIME-version: 1.0
Content-type: text/plain; charset=iso-8859-1
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


 Hi,
 This question is about MMU of MBX860 using MPC860 rather than LinuxPPC.
 I'm sorry to send not proper question to this board. Thank you so much if
you let me know proper and also active group.

 My question:
 In MPC860, is there any way for supervisor mode's kernel to access all
memory space
  whether its ASID matches with M_CASID even though some of memory space is
  configured to check ASID?

 I appreciate any help.

 My situation:
  I'm porting a microkernel into MBX860 using MPC860.
 For memory protection, this uses MMU even though address translation is not
necessary.
 Only one global memory address page table managed by kernel includes all
page table information for
  all application tasks for performance.
 It is possible by allocating memory space into each of application tasks.
 The requirements is that kernel in Privilege state can access all the
memory space
  but application task's access is restricted to the a memory space
allocated to itself.
 I think that the access violation between applications can be checked by
using ASID.
 So, I assign each ASID for memory space for applications and kernel.
 But I guess when ASID checking is enabled, kernel also can't access other
application's
  memory space because its ASID is different with others' ASID.

 Thank you so much.

 Okehee Goh





 ---------------------------------------
Real-Time System lab of CSE of ASU
Tel: 480-219-1346


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
