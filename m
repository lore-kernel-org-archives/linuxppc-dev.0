Return-Path: <jbe@pengutronix.de>
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de
	[92.198.50.35]) by ozlabs.org (Postfix) with ESMTP id 081BEDDDEE
	for <linuxppc-dev@ozlabs.org>; Sat,  6 Dec 2008 04:37:02 +1100 (EST)
From: Juergen Beisert <jbe@pengutronix.de>
To: linuxppc-dev@ozlabs.org
Date: Fri, 5 Dec 2008 18:36:50 +0100
References: <688884.68610.qm@web23105.mail.ird.yahoo.com>
	<49391C93.1070303@mlbassoc.com>
	<47602D18F269934AB73B7E550804A1E002137985@FBCMST09V03.fbc.local>
In-Reply-To: <47602D18F269934AB73B7E550804A1E002137985@FBCMST09V03.fbc.local>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200812051836.50960.jbe@pengutronix.de>
Subject: Re: R: Installation on a MPC5200 based custom board
Cc: s104259@yahoo.it, Gary Thomas <gary@mlbassoc.com>,
	gianfranco.casanova@alice.it
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Freitag, 5. Dezember 2008, gianfranco.casanova@alice.it wrote:
> ========================================================
>
> Now plugging-in USB:
>
> ========================================================
>
> root@RadioNav: ~ #[   17.228078] hub 1-0:1.0: state 7 ports 2 chg 0000 evt
> 0004 root@RadioNav: ~ #[   17.233798] ppc-of-ohci f0001000.usb: GetStatus
> roothub.portstatus [1] = 0x00010101 CSC PPS CCS root@RadioNav: ~ #[  
> 17.242776] hub 1-0:1.0: port 2, status 0101, change 0001, 12 Mb/s
> root@RadioNav: ~ #[   17.374796] hub 1-0:1.0: debounce: port 2: total 100ms
> stable 100ms status 0x101 root@RadioNav: ~ #[   17.450780] ppc-of-ohci
> f0001000.usb: GetStatus roothub.portstatus [1] = 0x00100103 PRSC PPS PES
> CCS root@RadioNav: ~ #[   17.514787] usb 1-2: new full speed USB device
> using ppc-of-ohci and address 2 root@RadioNav: ~ #[   24.027842] usb 1-2:
> khubd timed out on ep0in len=0/64 root@RadioNav: ~ #[   29.199841] usb 1-2:
> khubd timed out on ep0in len=0/64 root@RadioNav: ~ #[   34.307841] usb 1-2:
> khubd timed out on ep0in len=0/64 root@RadioNav: ~ #[   34.382786]
> ppc-of-ohci f0001000.usb: GetStatus roothub.portstatus [1] = 0x00100103
> PRSC PPS PES CCS root@RadioNav: ~ #[   34.446789] usb 1-2: device
> descriptor read/64, error -110 root@RadioNav: ~ #
> root@RadioNav: ~ #cat /proc/interrupts
>            CPU0
> 134:       5689  MPC52xx Peripherals Edge      ohci_hcd:usb1
> 139:        207  MPC52xx Peripherals Edge      mpc52xx_psc_uart
> 143:          0  MPC52xx Peripherals Edge      i2c-mpc
> 144:          0  MPC52xx Peripherals Edge      i2c-mpc
> BAD:          0
> root@RadioNav: ~ #
>
> ========================================================
>
> we were thinking to some problem like:
>
> http://www.nabble.com/USB-support-on-mpc5200-broken-td19658810.html
>
> or
>
> http://www.nabble.com/MPC5200-PCI-interrupt-routing-p19608472.html

Sounds like a wrong or missed clock configuration. Is your "CDM 48 MHz 
Fractional Divider Configuration Register Field Descriptions (0x0210)" setup 
correctly?

Some kernel revisions guesses and fixes the setting, some other not.

Regards,
Juergen

-- 
 Dipl.-Ing. Juergen Beisert | http://www.pengutronix.de
 Pengutronix - Linux Solutions for Science and Industry
   Handelsregister:  Amtsgericht Hildesheim, HRA 2686
          Vertretung Sued/Muenchen, Germany
  Phone: +49-8766-939 228  | Fax: +49-5121-206917-5555
