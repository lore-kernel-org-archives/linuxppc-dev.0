Message-ID: <19990914142953.21439.rocketmail@web601.yahoomail.com>
Date: Tue, 14 Sep 1999 16:29:53 +0200 (CEST)
From: sébastien tadéoni <sebastien_tadeoni@yahoo.fr>
Subject: Problem for compiling linux-2.2.5-embedded
To: Simon Brendan <brendan@dgs.monash.edu.au>,
        linux linuxppc dev <linuxppc-dev@lists.linuxppc.org>,
        linux linuxppc user <linuxppc-user@lists.linuxppc.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>



Hi All,

I've some problems with the cross-compilation of the 2.2.5-embedded
kernel for MPC860 (configure for a MBX card).

I followed the www.members.home.com/mmporter/cross.html instructions
for building my own environment and when I want to create the zImage I
have this current errors:

ppc_ksyms.c:77:'isa_io_base' undeclared here (not in a fonction)

ppc_ksyms.c:77:'initializer element for '--ksymtab_isa_io_base.value'
is not constant

In the ppc_ksyms.c I see EXPORT_SYMBOL(isa_io_base) and I don't no what
it minds.

For installing the binutils and the egcs-1.1.2 compiler I had to change
$PATH and add the /usr/local/bin address.
Was it wrong?

I will appreciate any suggestions and help on this subject.

Have a good day.

Sébastien.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
