Subject: Re: Need testers: G3 @ G4 laptops (powerbooks & ibooks)
From: digger vermont <digver@verizon.net>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: "debian-powerpc@lists.debian.org" <debian-powerpc@lists.debian.org>,
	linuxppc-dev list <linuxppc-dev@lists.linuxppc.org>
In-Reply-To: <1077074495.1082.94.camel@gaston>
References: <1077074495.1082.94.camel@gaston>
Content-Type: text/plain
Message-Id: <1077120235.22989.88.camel@myrna>
Mime-Version: 1.0
Date: Wed, 18 Feb 2004 11:03:56 -0500
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hello Ben,

	I just rsync'd to 2.6.3-rc3-ben1 and added your patch.  I get these
errors:

  UPD     include/linux/compile.h
  CC      init/version.o
  LD      init/built-in.o
  LD      .tmp_vmlinux1
drivers/built-in.o(.text+0x5f01c): In function `radeon_setup_i2c_bus':
: undefined reference to `i2c_bit_add_bus'
drivers/built-in.o(.text+0x5f17c): In function
`radeon_delete_i2c_busses':
: undefined reference to `i2c_bit_del_bus'
drivers/built-in.o(.text+0x5f184): In function
`radeon_delete_i2c_busses':
: undefined reference to `i2c_bit_del_bus'
drivers/built-in.o(.text+0x5f18c): In function
`radeon_delete_i2c_busses':
: undefined reference to `i2c_bit_del_bus'
drivers/built-in.o(.text+0x5f194): In function
`radeon_delete_i2c_busses':
: undefined reference to `i2c_bit_del_bus'
drivers/built-in.o(.text+0x5f224): In function
`radeon_do_probe_i2c_edid':
: undefined reference to `i2c_transfer'
make: *** [.tmp_vmlinux1] Error 1

2.6.3-rc2-ben1 compiled fine.  Does this have to do with your patch or
did I screw up my configuration?

digger


On Tue, 2004-02-17 at 22:21, Benjamin Herrenschmidt wrote:
> Hi need people who own those machiens, especially the recent iBook2 models
> with a G3 CPU and titanium powerbooks with a G4, to test this patch and
> tell me if sleep mode still works reliably or becomes unstable.
>
> (It won't help machines that cannot already sleep).
>
> Applies on top of current 2.6 but may apply to 2.4 as well..
>
> Thanks !
>
> Ben.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
