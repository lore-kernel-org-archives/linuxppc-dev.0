Message-ID: <3BB03BE9.57DBF420@imc-berlin.de>
Date: Tue, 25 Sep 2001 10:10:17 +0200
From: Steven Scholz <steven.scholz@imc-berlin.de>
MIME-Version: 1.0
To: LinuxPPC <linuxppc-embedded@lists.linuxppc.org>
Subject: BitKeeper and linuxppc_2_4
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi there,

again a "short" question about BitKeeper:

What's the difference between the tree linuxppc_2_4 and
linuxppc_2_4_devel?

It should be obvious, but:

I thought linuxppc_2_4 just contains released kernels. So the last
version should be 2.4.10.
So "bk changes -t" should show only released kernels, as is 2.4.8,
2.4.10 etc.
And if I cloned linuxppc_2_4 yesterday a "bk pull" should only result in
changes after a new release, i.e. after 2.4.12 is released.
But "bk changes -t" shows me several tags and

ChangeSet@1.2.2.70, 2001-09-23 14:30:18-07:00, trini@opus.bloom.county
  bk-work-patch-2.4.10pre15-2.4.10.patch.7974.new
  TAG: v2.4.10

ChangeSet@1.2.2.69, 2001-09-23 10:11:08-07:00, trini@opus.bloom.county
  bk-work-patch-2.4.10pre14-2.4.10pre15.patch.7207.new
  TAG: v2.4.10-pre15

ChangeSet@1.2.2.68, 2001-09-22 09:19:29-07:00,
trini@bill-the-cat.bloom.county
  bk-work-patch-2.4.10pre13-2.4.10pre14.patch.5558.new
  TAG: v2.4.10-pre14

...

and "bk pull" result in "Receiving the following csets : 1.377 1.376
1.375 1.372.1.1

Am I missing something? Is linuxppc_2_4 just the same as
linuxppc_2_4_devel?

My main problem is that I need a released version as a starting point
for my work, e.g 2.4.10.
So that all my patches and tests etc. are against the known version.
I tried a "bk -r undo -rv2.4.10". But I got

BitKeeper is unable to undo the requested changeset[s]...

The error caused by this undo is:
admin: revision 1.2.2.70 not at tip of branch in SCCS/s.ChangeSet.
SCCS/s.ChangeSet: admin:1.372 includes 1.2.2.70
output error: Broken pipe

Hmm. ???? Any ideas?

TIA.

Cheers,

Steven

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
