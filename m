From: jonb@marel.is
Subject: 8xxFADS and SingleStep BDM
To: psosuser@isi.com, linuxppc-embedded@lists.linuxppc.org
Date: Mon, 21 Feb 2000 11:39:12 +0000
Message-ID: <OF9754FB8B.2B42D5DE-ON0025688C.003AFCD8@marel.is>
MIME-Version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi

Is anyone using SDS SingleStep BDM with the 823FADS board from Motorola?
I am having some problems with this combination.  I get a connection
and I can read/write registers, initialize DRAM and read/write DRAM.
But when I try downloading an ELF file the result is always the same,
memory and registers are filled with garbage data after the download.

I would also like to use the SingleStep BDM flash programming tool, which
works successfully on our custom 821 board, but the flash programming tool
does not succeed in programming the 8xxFADS flash.

Does anyone have these tools working with 8xxFADS ?

I would be interested in sharing the config files.


Regards,

Jon Benediktsson
Marel hf.


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
