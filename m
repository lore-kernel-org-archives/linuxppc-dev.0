Date: Sat, 29 Jul 2000 11:11:11 -0500 (CDT)
From: Ramprasad Rao <ramp@oddjob.uchicago.edu>
To: Iain Sandoe <iain@sandoe.co.uk>
cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: 2.4.0-test5 build options.
In-Reply-To: <200007291341.OAA18843@hyperion.valhalla.net>
Message-ID: <Pine.GSU.4.05.10007291105240.10071-100000@oddjob.uchicago.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Iain -

I got 2.4.0-test5 from btkeeper to build on my USB only iMac. I did keep
all the ADB options as well. The relevant portions from my .config is
attached below. I just kept all the defaults from 'make common_config'.

- Ram

CONFIG_ADB=y
CONFIG_ADB_CUDA=y
CONFIG_ADB_MACIO=y
CONFIG_ADB_PMU=y
CONFIG_ADB_KEYBOARD=y
CONFIG_ADBMOUSE=y

#
# Mice
#
CONFIG_BUSMOUSE=y
CONFIG_ADBMOUSE=y
CONFIG_MOUSE=y
CONFIG_PSMOUSE=y

#
# USB support
#
CONFIG_USB=y
CONFIG_USB_OHCI=y
CONFIG_USB_HID=y
CONFIG_INPUT_KEYBDEV=y
CONFIG_INPUT_MOUSEDEV=y
CONFIG_INPUT_MOUSEDEV_SCREEN_X=1024
CONFIG_INPUT_MOUSEDEV_SCREEN_Y=768


On Sat, 29 Jul 2000, Iain Sandoe wrote:

>
> can anyone tell me the legal combination of ADB/USB/Input layer options that
> will work under 2.4.0-t5?
>
> After several aborted builds (either failed to compile or link) at half an
> hour a go... I'm getting a bit frustrated,
>
> I'm trying to do: ADB+USB (G3 mt)  ADB+USB (G3 Lombard) ADB only (9600).
>
> So, I guess, whatever will bring ADB+USB ought to do it.
>
> Iain.
>
>


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
