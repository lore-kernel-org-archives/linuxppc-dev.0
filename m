Message-ID: <3A2F6A6D.3D40327@wtal.de>
Date: Thu, 07 Dec 2000 11:46:05 +0100
From: Christof Petig <christof.petig@wtal.de>
MIME-Version: 1.0
To: linuxppc-dev@lists.linuxppc.org
Subject: Sound on an iBook?
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hello,

I got no answer on the debian-ppc list, so I'll try here.

does anybody know a way to get the sound hardware on my iBook working?
Everything else is working fine.

Your's
   Christof

OF says:
# cat
/proc/device-tree/pci@f2000000/mac-io@17/i2s@10000/i2s-a@10000/sound/compatible

daca
# cat
/proc/device-tree/pci@f2000000/mac-io@17/i2s@10000/i2s-a@10000/soun/device_type

soundchip
# cat
/proc/device-tree/pci@f2000000/mac-io@17/i2s@10000/i2s-a@10000/sound/model

353S0228
# cat
/proc/device-tree/pci@f2000000/mac-io@17/i2s@10000/i2s-a@10000/so/sound-objects

feature index 0 model Proj8PowerControlfeature index 1 model
USBSubwooferfeature index 2 model NotifySSprocketsdetect AAPL,address
0x00000064 bit-mask 2 bit-match 2 device 2 index 0 model GPIODetect
registry-name extint-gpio12input icon-id -20183 index 0 name-id -20540
port-connection 2 port-type 0x6D6F646D zero-gain 0 model
NoRecordInputinput index 1 model NoInputoutput device-mask 2
device-match 0 icon-id -16563 index 0 name-id -20525 port-connection 1
port-type 0x6973706b model OutputPortoutput device-mask 2 device-match 2
icon-id -16563 index 1 name-id -20524 port-connection 2 port-type
0x6864706e model OutputPort

# od -tu2
/proc/device-tree/pci@f2000000/mac-io@17/i2s@10000/i2s-a@10000/sound/sample-rates

0000000     0     1 44100     0

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
