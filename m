Return-Path: <lravich@gmail.com>
Received: from mail-wi0-x236.google.com (mail-wi0-x236.google.com
 [IPv6:2a00:1450:400c:c05::236])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 45C5A2C007A
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  6 Aug 2013 16:33:00 +1000 (EST)
Received: by mail-wi0-f182.google.com with SMTP id hi8so2440wib.3
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 05 Aug 2013 23:32:55 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAErSpo5ZZgdpkK+QdQUEnNCEXcG_T+QBWTVoQnMTghxkX7n2HA@mail.gmail.com>
References: <CAPWoNkJ3NKM-_g93LdRpjvdNFtLt-Pjpg4d4oEKC9CvkpzZ-Wg@mail.gmail.com>
 <CAPWoNkLQUbFG2vZ7wqoqqVNj4uxKz3Fa_vsSH=1_TDD=XC1f2A@mail.gmail.com>
 <CAErSpo5ZZgdpkK+QdQUEnNCEXcG_T+QBWTVoQnMTghxkX7n2HA@mail.gmail.com>
From: Leon Ravich <lravich@gmail.com>
Date: Tue, 6 Aug 2013 09:32:35 +0300
Message-ID: <CAPWoNkJtnE3ASH0AdgfAD-3soa13DyH-zZAyzWMg9K2=nCX87Q@mail.gmail.com>
Subject: Re: PCIE device errors after linux kernel upgrade
To: Bjorn Helgaas <bhelgaas@google.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Thanks Bjorn.

1) If I understand it right this patch only removes the "pci
0000:00:00.0: ignoring class 0x0b2000 (doesn't
match header type 01)" message , don't  care about it , had it before .

2) regarding the comparing of printouts:

kernel 3.8.13:

[   37.908846] pci_bus 0000:00: scanning bus
[   37.912870] pci 0000:00:00.0: [1957:0070] type 01 class 0x0b2000
[   37.918881] pci 0000:00:00.0: ignoring class 0x0b2000 (doesn't
match header type 01)
[   37.926640] pci 0000:00:00.0: calling fixup_hide_host_resource_fsl+0x0/0x5c
[   37.933596] pci 0000:00:00.0: calling pcibios_fixup_resources+0x0/0xf0
[   37.940132] pci 0000:00:00.0: calling quirk_fsl_pcie_header+0x0/0x78
[   37.946505] pci 0000:00:00.0: supports D1 D2
[   37.950779] pci 0000:00:00.0: PME# supported from D0 D1 D2 D3hot D3cold
[   37.957397] pci 0000:00:00.0: PME# disabled
[   37.961580] PCIE error(s) detected
[   37.964971] PCIE ERR_DR register: 0x00020000
[   37.969229] PCIE ERR_CAP_STAT register: 0x00000041
[   37.974008] PCIE ERR_CAP_R0 register: 0x00000800
[   37.978614] PCIE ERR_CAP_R1 register: 0x00000000
[   37.983218] PCIE ERR_CAP_R2 register: 0x00000000
[   37.987823] PCIE ERR_CAP_R3 register: 0x00000000
[   37.992448] PCIE error(s) detected
[   37.995841] PCIE ERR_DR register: 0x00020000
[   38.000098] PCIE ERR_CAP_STAT register: 0x00000041
[   38.004877] PCIE ERR_CAP_R0 register: 0x00000800
[   38.009482] PCIE ERR_CAP_R1 register: 0x00000000
[   38.014087] PCIE ERR_CAP_R2 register: 0x00000000
[   38.018692] PCIE ERR_CAP_R3 register: 0x00000000
[   38.023312] PCIE error(s) detected
[   38.026704] PCIE ERR_DR register: 0x00020000
[   38.030961] PCIE ERR_CAP_STAT register: 0x00000041
[   38.035740] PCIE ERR_CAP_R0 register: 0x00000800
[   38.040345] PCIE ERR_CAP_R1 register: 0x00000000
[   38.044950] PCIE ERR_CAP_R2 register: 0x00000000
[   38.049554] PCIE ERR_CAP_R3 register: 0x00000000
[   38.054180] PCIE error(s) detected
[   38.057573] PCIE ERR_DR register: 0x00020000
[   38.061831] PCIE ERR_CAP_STAT register: 0x00000041
[   38.066609] PCIE ERR_CAP_R0 register: 0x00000800
[   38.071214] PCIE ERR_CAP_R1 register: 0x00000000
[   38.075819] PCIE ERR_CAP_R2 register: 0x00000000
[   38.080424] PCIE ERR_CAP_R3 register: 0x00000000
[   38.085046] PCIE error(s) detected
[   38.088438] PCIE ERR_DR register: 0x00020000
[   38.092696] PCIE ERR_CAP_STAT register: 0x00000041
[   38.097474] PCIE ERR_CAP_R0 register: 0x00000800
[   38.102079] PCIE ERR_CAP_R1 register: 0x00000000
[   38.106684] PCIE ERR_CAP_R2 register: 0x00000000
[   38.111289] PCIE ERR_CAP_R3 register: 0x00000000
[   38.115909] PCIE error(s) detected
[   38.119301] PCIE ERR_DR register: 0x00020000
[   38.123559] PCIE ERR_CAP_STAT register: 0x00000041
[   38.128337] PCIE ERR_CAP_R0 register: 0x00000800
[   38.132942] PCIE ERR_CAP_R1 register: 0x00000000
[   38.137547] PCIE ERR_CAP_R2 register: 0x00000000
[   38.142152] PCIE ERR_CAP_R3 register: 0x00000000
[   38.146773] PCIE error(s) detected
[   38.150164] PCIE ERR_DR register: 0x00020000
[   38.154423] PCIE ERR_CAP_STAT register: 0x00000041
[   38.159201] PCIE ERR_CAP_R0 register: 0x00000800
[   38.163806] PCIE ERR_CAP_R1 register: 0x00000000
[   38.168410] PCIE ERR_CAP_R2 register: 0x00000000
[   38.173015] PCIE ERR_CAP_R3 register: 0x00000000
[   38.177635] PCIE error(s) detected
[   38.181028] PCIE ERR_DR register: 0x00020000
[   38.185286] PCIE ERR_CAP_STAT register: 0x00000041
[   38.190066] PCIE ERR_CAP_R0 register: 0x00000800
[   38.194670] PCIE ERR_CAP_R1 register: 0x00000000
[   38.199275] PCIE ERR_CAP_R2 register: 0x00000000
[   38.203880] PCIE ERR_CAP_R3 register: 0x00000000
[   38.208504] PCIE error(s) detected
[   38.211897] PCIE ERR_DR register: 0x00020000
[   38.216156] PCIE ERR_CAP_STAT register: 0x00000041
[   38.220935] PCIE ERR_CAP_R0 register: 0x00000800
[   38.225540] PCIE ERR_CAP_R1 register: 0x00000000
[   38.230144] PCIE ERR_CAP_R2 register: 0x00000000
[   38.234749] PCIE ERR_CAP_R3 register: 0x00000000
[   38.239395] PCIE error(s) detected
[   38.242788] PCIE ERR_DR register: 0x00020000
[   38.247046] PCIE ERR_CAP_STAT register: 0x00000041
[   38.251825] PCIE ERR_CAP_R0 register: 0x00000800
[   38.256430] PCIE ERR_CAP_R1 register: 0x00000000
[   38.261034] PCIE ERR_CAP_R2 register: 0x00000000
[   38.265639] PCIE ERR_CAP_R3 register: 0x00000000
[   38.270268] PCIE error(s) detected
[   38.273660] PCIE ERR_DR register: 0x00020000
[   38.277918] PCIE ERR_CAP_STAT register: 0x00000041
[   38.282697] PCIE ERR_CAP_R0 register: 0x00000800
[   38.287302] PCIE ERR_CAP_R1 register: 0x00000000
[   38.291906] PCIE ERR_CAP_R2 register: 0x00000000
[   38.296511] PCIE ERR_CAP_R3 register: 0x00000000
[   38.301134] PCIE error(s) detected
[   38.304526] PCIE ERR_DR register: 0x00020000
[   38.308784] PCIE ERR_CAP_STAT register: 0x00000041
[   38.313563] PCIE ERR_CAP_R0 register: 0x00000800
[   38.318168] PCIE ERR_CAP_R1 register: 0x00000000
[   38.322772] PCIE ERR_CAP_R2 register: 0x00000000
[   38.327377] PCIE ERR_CAP_R3 register: 0x00000000
[   38.331999] PCIE error(s) detected
[   38.335390] PCIE ERR_DR register: 0x00020000
[   38.339648] PCIE ERR_CAP_STAT register: 0x00000041
[   38.344427] PCIE ERR_CAP_R0 register: 0x00000800
[   38.349031] PCIE ERR_CAP_R1 register: 0x00000000
[   38.353636] PCIE ERR_CAP_R2 register: 0x00000000
[   38.358241] PCIE ERR_CAP_R3 register: 0x00000000
[   38.362862] PCIE error(s) detected
[   38.366255] PCIE ERR_DR register: 0x00020000
[   38.370512] PCIE ERR_CAP_STAT register: 0x00000041
[   38.375291] PCIE ERR_CAP_R0 register: 0x00000800
[   38.379896] PCIE ERR_CAP_R1 register: 0x00000000
[   38.384501] PCIE ERR_CAP_R2 register: 0x00000000
[   38.389106] PCIE ERR_CAP_R3 register: 0x00000000
[   38.393728] PCIE error(s) detected
[   38.397121] PCIE ERR_DR register: 0x00020000
[   38.401379] PCIE ERR_CAP_STAT register: 0x00000041
[   38.406158] PCIE ERR_CAP_R0 register: 0x00000800
[   38.410763] PCIE ERR_CAP_R1 register: 0x00000000
[   38.415367] PCIE ERR_CAP_R2 register: 0x00000000
[   38.419972] PCIE ERR_CAP_R3 register: 0x00000000
[   38.424613] PCIE error(s) detected
[   38.428007] PCIE ERR_DR register: 0x00020000
[   38.432264] PCIE ERR_CAP_STAT register: 0x00000041
[   38.437043] PCIE ERR_CAP_R0 register: 0x00000800
[   38.441648] PCIE ERR_CAP_R1 register: 0x00000000
[   38.446253] PCIE ERR_CAP_R2 register: 0x00000000
[   38.450857] PCIE ERR_CAP_R3 register: 0x00000000
[   38.455483] PCIE error(s) detected
[   38.458875] PCIE ERR_DR register: 0x00020000
[   38.463133] PCIE ERR_CAP_STAT register: 0x00000041
[   38.467911] PCIE ERR_CAP_R0 register: 0x00000800
[   38.472516] PCIE ERR_CAP_R1 register: 0x00000000
[   38.477121] PCIE ERR_CAP_R2 register: 0x00000000
[   38.481726] PCIE ERR_CAP_R3 register: 0x00000000
[   38.486351] PCIE error(s) detected
[   38.489743] PCIE ERR_DR register: 0x00020000
[   38.494001] PCIE ERR_CAP_STAT register: 0x00000041
[   38.498780] PCIE ERR_CAP_R0 register: 0x00000800
[   38.503385] PCIE ERR_CAP_R1 register: 0x00000000
[   38.507989] PCIE ERR_CAP_R2 register: 0x00000000
[   38.512594] PCIE ERR_CAP_R3 register: 0x00000000
[   38.517212] PCIE error(s) detected
[   38.520603] PCIE ERR_DR register: 0x00020000
[   38.524860] PCIE ERR_CAP_STAT register: 0x00000041
[   38.529639] PCIE ERR_CAP_R0 register: 0x00000800
[   38.534244] PCIE ERR_CAP_R1 register: 0x00000000
[   38.538849] PCIE ERR_CAP_R2 register: 0x00000000
[   38.543453] PCIE ERR_CAP_R3 register: 0x00000000
[   38.548069] PCIE error(s) detected
[   38.551461] PCIE ERR_DR register: 0x00020000
[   38.555719] PCIE ERR_CAP_STAT register: 0x00000041
[   38.560497] PCIE ERR_CAP_R0 register: 0x00000800
[   38.565102] PCIE ERR_CAP_R1 register: 0x00000000
[   38.569707] PCIE ERR_CAP_R2 register: 0x00000000
[   38.574312] PCIE ERR_CAP_R3 register: 0x00000000
[   38.578928] PCIE error(s) detected
[   38.582318] PCIE ERR_DR register: 0x00020000
[   38.586576] PCIE ERR_CAP_STAT register: 0x00000041
[   38.591354] PCIE ERR_CAP_R0 register: 0x00000800
[   38.595959] PCIE ERR_CAP_R1 register: 0x00000000
[   38.600564] PCIE ERR_CAP_R2 register: 0x00000000
[   38.605169] PCIE ERR_CAP_R3 register: 0x00000000
[   38.609784] PCIE error(s) detected
[   38.613175] PCIE ERR_DR register: 0x00020000
[   38.617433] PCIE ERR_CAP_STAT register: 0x00000041
[   38.622211] PCIE ERR_CAP_R0 register: 0x00000800
[   38.626816] PCIE ERR_CAP_R1 register: 0x00000000
[   38.631421] PCIE ERR_CAP_R2 register: 0x00000000
[   38.636026] PCIE ERR_CAP_R3 register: 0x00000000
[   38.640658] PCIE error(s) detected
[   38.644050] PCIE ERR_DR register: 0x00020000
[   38.648309] PCIE ERR_CAP_STAT register: 0x00000041
[   38.653088] PCIE ERR_CAP_R0 register: 0x00000800
[   38.657692] PCIE ERR_CAP_R1 register: 0x00000000
[   38.662297] PCIE ERR_CAP_R2 register: 0x00000000
[   38.666902] PCIE ERR_CAP_R3 register: 0x00000000
[   38.671522] PCIE error(s) detected
[   38.674914] PCIE ERR_DR register: 0x00020000
[   38.679172] PCIE ERR_CAP_STAT register: 0x00000041
[   38.683951] PCIE ERR_CAP_R0 register: 0x00000800
[   38.688556] PCIE ERR_CAP_R1 register: 0x00000000
[   38.693161] PCIE ERR_CAP_R2 register: 0x00000000
[   38.697766] PCIE ERR_CAP_R3 register: 0x00000000
[   38.702386] PCIE error(s) detected
[   38.705777] PCIE ERR_DR register: 0x00020000
[   38.710034] PCIE ERR_CAP_STAT register: 0x00000041
[   38.714813] PCIE ERR_CAP_R0 register: 0x00000800
[   38.719418] PCIE ERR_CAP_R1 register: 0x00000000
[   38.724023] PCIE ERR_CAP_R2 register: 0x00000000
[   38.728628] PCIE ERR_CAP_R3 register: 0x00000000
[   38.733244] PCIE error(s) detected
[   38.736636] PCIE ERR_DR register: 0x00020000
[   38.740895] PCIE ERR_CAP_STAT register: 0x00000041
[   38.745673] PCIE ERR_CAP_R0 register: 0x00000800
[   38.750278] PCIE ERR_CAP_R1 register: 0x00000000
[   38.754883] PCIE ERR_CAP_R2 register: 0x00000000
[   38.759488] PCIE ERR_CAP_R3 register: 0x00000000
[   38.764103] PCIE error(s) detected
[   38.767494] PCIE ERR_DR register: 0x00020000
[   38.771752] PCIE ERR_CAP_STAT register: 0x00000041
[   38.776530] PCIE ERR_CAP_R0 register: 0x00000800
[   38.781135] PCIE ERR_CAP_R1 register: 0x00000000
[   38.785740] PCIE ERR_CAP_R2 register: 0x00000000
[   38.790344] PCIE ERR_CAP_R3 register: 0x00000000
[   38.794984] PCIE error(s) detected
[   38.798377] PCIE ERR_DR register: 0x00020000
[   38.802635] PCIE ERR_CAP_STAT register: 0x00000041
[   38.807414] PCIE ERR_CAP_R0 register: 0x00000800
[   38.812019] PCIE ERR_CAP_R1 register: 0x00000000
[   38.816624] PCIE ERR_CAP_R2 register: 0x00000000
[   38.821229] PCIE ERR_CAP_R3 register: 0x00000000
[   38.825848] PCIE error(s) detected
[   38.829239] PCIE ERR_DR register: 0x00020000
[   38.833496] PCIE ERR_CAP_STAT register: 0x00000041
[   38.838275] PCIE ERR_CAP_R0 register: 0x00000800
[   38.842880] PCIE ERR_CAP_R1 register: 0x00000000
[   38.847485] PCIE ERR_CAP_R2 register: 0x00000000
[   38.852090] PCIE ERR_CAP_R3 register: 0x00000000
[   38.856712] PCIE error(s) detected
[   38.860103] PCIE ERR_DR register: 0x00020000
[   38.864361] PCIE ERR_CAP_STAT register: 0x00000041
[   38.869139] PCIE ERR_CAP_R0 register: 0x00000800
[   38.873744] PCIE ERR_CAP_R1 register: 0x00000000
[   38.878349] PCIE ERR_CAP_R2 register: 0x00000000
[   38.882954] PCIE ERR_CAP_R3 register: 0x00000000
[   38.887574] PCIE error(s) detected
[   38.890966] PCIE ERR_DR register: 0x00020000
[   38.895223] PCIE ERR_CAP_STAT register: 0x00000041
[   38.900002] PCIE ERR_CAP_R0 register: 0x00000800
[   38.904607] PCIE ERR_CAP_R1 register: 0x00000000
[   38.909212] PCIE ERR_CAP_R2 register: 0x00000000
[   38.913817] PCIE ERR_CAP_R3 register: 0x00000000
[   38.918446] pci 0000:00:00.0: scanning [bus 01-01] behind bridge, pass 0
[   38.925142] pci 0000:00:00.0: scanning [bus 00-00] behind bridge, pass 1
[   38.931873] pci_bus 0000:01: busn_res: can not insert [bus 01-ff]
under [bus 00-01] (conflicts with (null) [bus 00-01])
[   38.942654] pci_bus 0000:01: scanning bus
[   38.946687] pci 0000:01:00.0: [1234:0002] type 00 class 0xff0000
[   38.952697] pci 0000:01:00.0: reg 10: [mem 0x00000000-0x000fffff]
[   38.958801] pci 0000:01:00.0: reg 14: [mem 0x00000000-0x0007ffff]
[   38.964891] pci 0000:01:00.0: reg 18: [mem 0x00000000-0x0007ffff]
[   38.971017] pci 0000:01:00.0: calling pcibios_fixup_resources+0x0/0xf0
[   38.977605] pci_bus 0000:01: fixups for bus
[   38.981782] pci 0000:00:00.0: PCI bridge to [bus 01-ff]
[   38.987012] pci 0000:00:00.0:   bridge window [io  0x0000-0x0fff]
[   38.993098] pci 0000:00:00.0:   bridge window [mem 0xc0000000-0xdfffffff]
[   38.999970] pci_bus 0000:01: bus scan returning with max=01
[   39.005537] pci_bus 0000:01: busn_res: [bus 01-ff] end is updated to 01
[   39.012158] pci_bus 0000:00: bus scan returning with max=01
[   39.017749] pci 0000:00:00.0: BAR 8: assigned [mem 0xc0000000-0xdfffffff]
[   39.024530] pci 0000:00:00.0: BAR 7: can't assign io (size 0x10000)
[   39.030801] pci 0000:01:00.0: BAR 0: assigned [mem 0xc0000000-0xc00fffff]
[   39.037596] pci 0000:01:00.0: BAR 0: set to [mem
0xc0000000-0xc00fffff] (PCI address [0xc0000000-0xc00fffff])
[   39.047511] pci 0000:01:00.0: BAR 1: assigned [mem 0xc0100000-0xc017ffff]
[   39.054293] pci 0000:01:00.0: BAR 1: set to [mem
0xc0100000-0xc017ffff] (PCI address [0xc0100000-0xc017ffff])
[   39.064204] pci 0000:01:00.0: BAR 2: assigned [mem 0xc0180000-0xc01fffff]
[   39.070997] pci 0000:01:00.0: BAR 2: set to [mem
0xc0180000-0xc01fffff] (PCI address [0xc0180000-0xc01fffff])
[   39.080910] pci 0000:00:00.0: PCI bridge to [bus 01]
[   39.085866] pci 0000:00:00.0:   bridge window [mem 0xc0000000-0xdfffffff]
[   39.092662] pci 0000:00:00.0: enabling bus mastering




kernel 2.6.32

[   49.665070] PCI: Scanning bus 0000:00
[   49.668744] pci 0000:00:00.0: found [1957:0070] class 000b20 header type 01
[   49.675708] pci 0000:00:00.0: ignoring class b20 (doesn't match
header type 01)
[   49.683028] pci 0000:00:00.0: calling fixup_hide_host_resource_fsl+0x0/0x5c
[   49.689991] pci 0000:00:00.0: calling pcibios_fixup_resources+0x0/0xd0
[   49.696525] pci 0000:00:00.0: calling quirk_fsl_pcie_header+0x0/0x64
[   49.702885] pci 0000:00:00.0: calling quirk_resource_alignment+0x0/0x1d4
[   49.709583] pci 0000:00:00.0: supports D1 D2
[   49.713851] pci 0000:00:00.0: PME# supported from D0 D1 D2 D3hot D3cold
[   49.720457] pci 0000:00:00.0: PME# disabled
[   49.724657] pci 0000:00:00.0: scanning behind bridge, config 010100, pass 0
[   49.731611] pci 0000:00:00.0: scanning behind bridge, config 000000, pass 1
[   49.738576] PCI: Scanning bus 0000:01
[   49.742256] pci 0000:01:00.0: found [1234:0002] class 00ff00 header type 00
[   49.749224] pci 0000:01:00.0: reg 10 32bit mmio: [0x000000-0x0fffff]
[   49.755584] pci 0000:01:00.0: reg 14 32bit mmio: [0x000000-0x07ffff]
[   49.761932] pci 0000:01:00.0: reg 18 32bit mmio: [0x000000-0x07ffff]
[   49.768302] pci 0000:01:00.0: calling pcibios_fixup_resources+0x0/0xd0
[   49.774830] pci 0000:01:00.0: calling quirk_resource_alignment+0x0/0x1d4
[   49.781566] PCI: Fixups for bus 0000:01
[   49.785402] pci 0000:00:00.0: bridge io port: [0x00-0xfff]
[   49.790879] pci 0000:00:00.0: bridge 32bit mmio: [0xc0000000-0xdfffffff]
[   49.797627] PCI: Bus scan for 0000:01 returning with max=01
[   49.803200] PCI: Bus scan for 0000:00 returning with max=01
[   49.808777] pci 0000:01:00.0: BAR 0: got res
[0xc0000000-0xc00fffff] bus [0xc0000000-0xc00fffff] flags 0x20020200
[   49.819041] pci 0000:01:00.0: BAR 0: moved to bus
[0xc0000000-0xc00fffff] flags 0x20200
[   49.827043] pci 0000:01:00.0: BAR 1: got res
[0xc0100000-0xc017ffff] bus [0xc0100000-0xc017ffff] flags 0x20020200
[   49.837303] pci 0000:01:00.0: BAR 1: moved to bus
[0xc0100000-0xc017ffff] flags 0x20200
[   49.845306] pci 0000:01:00.0: BAR 2: got res
[0xc0180000-0xc01fffff] bus [0xc0180000-0xc01fffff] flags 0x20020200
[   49.855566] pci 0000:01:00.0: BAR 2: moved to bus
[0xc0180000-0xc01fffff] flags 0x20200
[   49.863568] pci 0000:00:00.0: PCI bridge, secondary bus 0000:01
[   49.869477] pci 0000:00:00.0:   IO window: disabled
[   49.874352] pci 0000:00:00.0:   MEM window: 0xc0000000-0xc01fffff
[   49.880436] pci 0000:00:00.0:   PREFETCH window: disabled



On 5 August 2013 18:38, Bjorn Helgaas <bhelgaas@google.com> wrote:
> [+cc linuxppc-dev]
>
> On Mon, Aug 5, 2013 at 5:17 AM, Leon Ravich <lravich@gmail.com> wrote:
>> Hi all ,
>> I am trying to upgrade ours embedded device (freescale powerPC P2020 cpu)
>> linux kernel  , till now we used 2.6.32 I am trying to upgrade to 3.8.13 .
>> I took the source from freescale git:
>> git://git.freescale.com/ppc/sdk/linux.git
>>
>> on our embedded device we have an FPGA connected through PCIE .
>>
>> on each boot we loading the rbf design to the FPGA and the rescan pci bus to let
>> kernel detect it .
>>
>> during the rescan I getting error messages:
>>  genirq: Setting trigger mode 0 for irq 27 failed
>> (mpc8xxx_irq_set_type+0x0/0xec)
>> [   22.060898] genirq: Setting trigger mode 0 for irq 28 failed
>> (mpc8xxx_irq_set_type+0x0/0xec)
>> [   22.069461] genirq: Setting trigger mode 0 for irq 31 failed
>> (mpc8xxx_irq_set_type+0x0/0xec)
>> [   22.078010] genirq: Setting trigger mode 0 for irq 32 failed
>> (mpc8xxx_irq_set_type+0x0/0xec)
>> [   22.086576] genirq: Setting trigger mode 0 for irq 33 failed
>> (mpc8xxx_irq_set_type+0x0/0xec)
>> [   22.095143] genirq: Setting trigger mode 0 for irq 37 failed
>> (mpc8xxx_irq_set_type+0x0/0xec)
>> [   22.103715] genirq: Setting trigger mode 0 for irq 38 failed
>> (mpc8xxx_irq_set_type+0x0/0xec)
>> [   22.112282] genirq: Setting trigger mode 0 for irq 39 failed
>> (mpc8xxx_irq_set_type+0x0/0xec)
>
> Hmm, I don't know much about IRQ issues.
>
>> [   37.945785] pci 0000:00:00.0: ignoring class 0x0b2000 (doesn't
>> match header type 01)
>
> There's a recent patch related to this:
> http://lkml.kernel.org/r/1374823418-1550-1-git-send-email-Chunhe.Lan@freescale.com
>
>> [   37.953640] PCIE error(s) detected
>> [   37.953858] pci 0000:00:00.0: PCI bridge to [bus 01-ff]
>> [   37.953988] pci 0000:00:00.0: BAR 8: assigned [mem 0xc0000000-0xdfffffff]
>> [   37.953994] pci 0000:00:00.0: BAR 7: can't assign io (size 0x10000)
>> [   37.954000] pci 0000:01:00.0: BAR 0: assigned [mem 0xc0000000-0xc00fffff]
>> [   37.954013] pci 0000:01:00.0: BAR 1: assigned [mem 0xc0100000-0xc017ffff]
>> [   37.954025] pci 0000:01:00.0: BAR 2: assigned [mem 0xc0180000-0xc01fffff]
>> [   37.954036] pci 0000:00:00.0: PCI bridge to [bus 01]
>> [   37.954041] pci 0000:00:00.0:   bridge window [mem 0xc0000000-0xdfffffff]
>> [   38.007354] PCIE ERR_DR register: 0x80020000
>> [   38.011613] PCIE ERR_CAP_STAT register: 0x00000041
>> [   38.016392] PCIE ERR_CAP_R0 register: 0x00000800
>> [   38.020997] PCIE ERR_CAP_R1 register: 0x00000000
>> [   38.025602] PCIE ERR_CAP_R2 register: 0x00000000
>> [   38.030207] PCIE ERR_CAP_R3 register: 0x00000000
>>
>>
>> and after a few minutes I linux reboot it self,
>>
>>
>> where can I start debugging it??
>
> I'd start by applying the header quirk patch above, then comparing the
> complete console log (boot with "ignore_loglevel") from 2.6.32 and
> 3.8.13.
>
> Bjorn



-- 
Leonid Ravich
