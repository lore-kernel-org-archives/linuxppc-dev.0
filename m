Message-ID: <12d801c3db4b$4b7ab930$3cc8a8c0@ANOSP>
From: "Colin Leroy" <colin@colino.net>
To: <linuxppc-dev@lists.linuxppc.org>
Subject: Re: temp.c and cputable.c issues
Date: Thu, 15 Jan 2004 10:38:13 +0100
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


> i've an ibook G4/12". it's branded as PowerMac6,3. It should be
> the lastest model available from apple.
>
> > You may have an external chipset used to check temperatures and
control
> > the fan.
>
> sure. there's an external chipset for temperature and fan control.
> Under Macos X, i've set and get values from it several times...but
> what about linux ?


Well, under 2.6 kernel, you can use the therm_adt7467 module
(CONFIG_THERM_IBOOKG4 configuration option, under Drivers/Macintosh).
It'll create some entries in /sys:
/sys/devices/temperatures/cpu_temperature
/sys/devices/temperatures/gpu_temperature
/sys/devices/temperatures/fan_speed
These display the informations you want.

/sys/devices/temperatures/cpu_limit
/sys/devices/temperatures/gpu_limit
These display the maximum temperatures before fan starts.

--
Colin
Ne disez pas disez, mais disez dites

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
