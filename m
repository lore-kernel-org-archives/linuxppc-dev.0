Message-ID: <007401c19cff$40b805c0$8e00010a@aztec.local>
From: "Frederic Soulier" <soulier@aztec-radiomedia.com>
To: =?iso-8859-1?Q?David_de_Andr=E9s_Mart=EDnez?= <ddandres@disca.upv.es>,
	<linuxppc-embedded@lists.linuxppc.org>
References: <3C417B00.A0DCAE7@disca.upv.es>
Subject: Re: LinuxPPC for MPC555?
Date: Mon, 14 Jan 2002 14:27:45 +0100
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


The Motorola MPC-555 is MMU-less. Classical Linux ports do not support this
kind of microcontrollers.
If your OS requirements are about Linux facilities, you may consider the
uCLinux project : http://www.uclinux.{org, com} but I have never heard about
a successful uCLinux MPC-555 port.
If your requirements are less restrictive and simply about an open source
OS, you may consider other projects like RTEMS (http://www.rtems.com) or
eCos (http://sources.redhat.com/ecos). I know some guys had sucessfuly used
them with MPC-555 so you have to browse these projects development
mailing-lists.

> I know it's a bit strange, but we are looking for a LinuxPPC port for
> the Motorola MPC555.
>
> Does anyone know where can we find this port, or if it can be easily
> done?

Frederic


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
