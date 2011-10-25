Return-Path: <galak@kernel.crashing.org>
Subject: Re: MPC8548 core "freezes"
Mime-Version: 1.0 (Apple Message framework v1251.1)
Content-Type: text/plain; charset=us-ascii
From: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <4CE4CD7158AFEE44A025CA3D42C323811B16E1D65A@spvw1505.ONE-05.GRP>
Date: Tue, 25 Oct 2011 15:28:00 -0500
Message-Id: <138EDED0-EA33-44BD-A0DD-DBE6D5C7BFB6@kernel.crashing.org>
References: <4CE4CD7158AFEE44A025CA3D42C323811B16E1D65A@spvw1505.ONE-05.GRP>
To: JACOBS Willy <willy.jacobs@nl.thalesgroup.com>
Cc: "Linuxppc-dev@lists.ozlabs.org" <Linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Oct 25, 2011, at 9:37 AM, JACOBS Willy wrote:

> We discover on our own developed board based on a MPC8548, a FPGA =
connected
> through the PCIe bus which the PQ3, and running U-BOOT, Linux 2.6.33.7 =
(+ RT
> patches), and a Wind River 2.0 root file system on irregular =
occurrences that the
> PQ3 "freezes". The main application running on the PQ3 transfer data =
between the
> FPGA/PCIe (bi-directional over several PCIe lanes) and the MOTTSECs =
(at gigabit
> speed). =20
> With a Wind River Probe we can connected to the PQ3 JTAG, and to look
> into the PQ3 registers. In the erroneous state we always see:
>=20
> - all the CPU e500 core registers have the value 0
> - the L1 I/D caches are disabled
> - the L2 cache is still enabled
> - the DDR SDRAM logic is disabled (DDR_SDRAM_CFG[MEN_EN] =3D 0); the =
other DDR_SDRAM_CFG bits contains the programmed value
> - the contents of the remaining peripheral registers look OK
>=20
> We have already swapped boards, without any success.
> On the same boards we have also other applications running without =
this "freeze" problem.
> Because no exception are generated it's very difficult to catch the =
root cause.
> So any help is appreciated.
>=20
> U-Boot 2009.01.01 (Oct 08 2010 - 08:35:06)
>=20
> CPU:   8548, Version: 2.1, (0x80310021)
> Core:  E500, Version: 2.2, (0x80210022)
> Clock Configuration:
>       CPU:1333.333 MHz, CCB:533.333 MHz,
>       DDR:266.667 MHz (533.333 MT/s data rate), LBC:66.667 MHz
> L1:    D-cache 32 kB enabled
>       I-cache 32 kB enabled
> I2C:   ready
> Board: thales,payarapc8548, 12nc: 955683208506, snr: 0014
> DRAM:      DDR:  2 GB
> FLASH: 128 MB
> L2:    512 KB enabled
>    PCI: 32 bit, 66 MHz, async, host, arbiter
>               Scanning PCI bus 00
> PCI on bus 00 - 00
>=20
>    PCIE connected to slot as Root Complex (base address e000a000)
> PCIE on bus 1 - 1
> In:    serial
> Out:   serial
> Err:   serial
> Net:   tsec0, tsec1, tsec2 [PRIME]


You appear to be freezing in u-boot, should ask your question on that =
list.

- k=
