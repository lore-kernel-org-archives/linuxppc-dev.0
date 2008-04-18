Return-Path: <d.stonier@gmail.com>
Message-ID: <27dfa3d0804171704j711aad1cwe7b558c077da3350@mail.gmail.com>
Date: Fri, 18 Apr 2008 09:04:51 +0900
From: "Daniel Stonier" <d.stonier@gmail.com>
To: Linuxppc-embedded@ozlabs.org
Subject: eldk and usb to serial converters
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_Part_557_19763838.1208477091679"
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

------=_Part_557_19763838.1208477091679
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi all,

I'm currently trying to compile a kernel for an AMCC440EP board within an
eldk environment. We've got a FTDI usb2serial converter we need to connect
to the board. Now I've compiled a kernel on a gentoo machine for this device
and had no problems. With this board, the kernel recognizes the device fine:

ftdi_sio 1-1:1.0: FTDI USB Serial Device converter detected
usb 1-1: FTDI USB Serial Device converter now attached to ttyUSB0
drivers/usb/serial/ftdi_sio.c: v1.4.3:USB FTDI Serial Converters Driver

but udev doesn't actually make the ttyUSB0 node. If anyone knows what may
have caused the problem and how to fix it, it'd be much appreciated.

Cheers,
Daniel.

------=_Part_557_19763838.1208477091679
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi all,<br><br>I&#39;m currently trying to compile a kernel for an AMCC440EP board within an eldk environment. We&#39;ve got a FTDI usb2serial converter we need to connect to the board. Now I&#39;ve compiled a kernel on a gentoo machine for this device and had no problems. With this board, the kernel recognizes the device fine:<br>
<br>ftdi_sio 1-1:1.0: FTDI USB Serial Device converter detected<br>usb 1-1: FTDI USB Serial Device converter now attached to ttyUSB0<br>drivers/usb/serial/ftdi_sio.c: v1.4.3:USB FTDI Serial Converters Driver<br><br>but udev doesn&#39;t actually make the ttyUSB0 node. If anyone knows what may have caused the problem and how to fix it, it&#39;d be much appreciated.<br>
<br>Cheers,<br>Daniel.<br><br>

------=_Part_557_19763838.1208477091679--
