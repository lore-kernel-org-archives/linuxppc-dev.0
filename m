Subject: Lite5200 USB with Vbus=1.7V
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Date: Tue, 22 Jun 2004 17:41:34 +0200
Message-ID: <42A622EB18325843894BB8E1040E3DF5022759@sinaexchf>
From: =?iso-8859-1?Q?I=F1igo_Lopez_Barranco?= <ilopez@albatros-sl.es>
To: <linuxppc-embedded@lists.linuxppc.org>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi again.
I been trying to use a Kingston USB stick with the Lite5200, but it's not seen from linux nor from u-boot, though it works without problems on any linux PC.

The USB diode (D85 on schematics) is off, and I've found that Vbus in the USB connector, coming from pins 6 and 8 of the MIC2025 (U27) is only ~1.7V. Could anyone compare this value with a Lite5200 working USB?

The voltage input (pin 7) of the MIC2025 chip (U27) is 5V, and the enable (pin 1 connected to USB1_PORTPWR_S in the MPC5200) has 3.3V. The pin 2 FLG output is 3.1V and is active low, so it's telling the MPC5200 that there is no overcurrent, right?

The only strange thing is that in Motorola's schematics says that pins 3 and 5 of the Micrel 2025 are Not Connected and 4 is GND, and Micrel's 2025 datasheet says that 3 is GND and 4 and 5 NC.
Then, in the Lite5200 GND pin 3 is connected to GND through an 1k resistor, instead of directly as I suppose they pretended in the schematic, and 4 NC pin is conected directly to GND. I'm not sure if this might be the cause of the problen, but placing an oscilloscope probe between pin 3 and GND shows a 2V periodic signal with ton=4us and toff=10us approx. Is this a known problem or my board has something broken? (don't think I can connect anything upside down this time).
Thank you.

Iñigo

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
