From: brian.auld@adic.com
Message-ID: <995FF289C9D69747A09E42992644595405B23665@penguin.adic.com>
To: linuxppc-embedded@lists.linuxppc.org
Subject: How to use bitkeeper going forward??
Date: Tue, 11 Feb 2003 13:00:52 -0800
MIME-Version: 1.0
Content-Type: text/plain
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hopefully someone can help clear the cobwebs.

Up until now, I have used CVS as source control on previous development (not
involving the linux kernel) projects. You probably recognize me as the one
embarking on an embedded 440GP project (if you haven't filtered me out
already :-)). I'm having trouble getting my hands around bitkeeper and
understanding how I will source control the kernel going forward.

We will use the linuxppc_2_4_devel kernel and will obviously do porting work
for our custom hardware. How do people usually manage their kernel source in
these cases? Is it expected/required that the public kernel source
eventually contain board level code for our company's custom hardware? Or,
do people typically 'clone' a copy of the kernel and then internally manage
and maitain a custom kernel tree for their board that remains separate from
the bitkeeper dev tree? If it's kept in-house, what is the best way to
manage this? A combination of bitkeeper and CVS (bitkeeper to get updates
... CVS to manage the source internally), or bitkeeper all the way? I might
want to do some branching as we develop, and I didn't notice any branching
capability with bitkeeper.

One thing I tried today was to export the kernel tree as of 2.4.20. I soon
found out that I had used the wrong tag from the changeset list (v2.4.20
instead of v2.4.20_linuxppc_2_4_devel). If I cloned the linuxppc_2_4_devel
tree in the first place, why are "non-ppc_2_4_devel" tags mixed into the
changeset list?

Another question. How do I determine what the latest version of
linuxppc_2_4_devel is out there without looking at the top-level Makefile of
the latest pull/clone? Is there a way to reliably extract this from the
changset list? Take for example the tags in the changeset list for the
lastest ppc_2_4_devel release(s). The most recent is 2.4.21-pre4, yet the
label accompanying changeset 1.1244 says "v2.4.20-pre4_linuxppc_2_4_devel"
with a "merge to 2.4.21-pre4" in the comments area. I would have expected
the label to read "v2.4.21 ..." not "2.4.20...". The second to last labelled
changeset for ppc_2_4_devel states "v.2.4.21-pre3_linuxppc_2_4_devel" as I
would expect. Is the pre4 case mislabelled or am I missing something here?

Any feedback or pointers to howtos on bitkeeper would be appreciated. I've
already ready the documentation at the bitmover website and it's more of a
command reference than a concepts discussion.

Respectfully,

-- Brian


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
