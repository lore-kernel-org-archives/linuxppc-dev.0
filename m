Date: Sat, 30 Jan 1999 15:24:20 +0100 (CET)
From: Gerd Knorr <kraxel@goldbach.in-berlin.de>
To: linuxppc-dev@lists.linuxppc.org
Subject: iMac: sound?
Message-ID: <Pine.LNX.4.05.9901301512490.313-100000@macintoy.masq.in-berlin.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>



  Hi !

Is the existing Amiga/PowerMac DMAsound driver supported to work on the
iMac too?  Simply insmoding it seems not to work, I get these messages in
the syslog:

	AWACS: error, status = 4f00d0
	DMA sound driver: Interrupt initialization failed

In /proc/device-tree/pci/mac-io/davbus/sound I've found:

$ for a in *; do echo "$a: `cat $a`"; done | tee ~/y
#input-channels: 
#output-channels: 
compatible: burgundy
device-id: 
device_type: sound
input-encoding-types: 16bit-BE-signed-linear
input-frame-rates: 
model: 343S0177
name: sound
output-encoding-types: 16bit-BE-signed-linear
output-frame-rates: 
sample-frame-size: 
sample-precisions: 
sub-frame: 
vendor-id: 

Any hints?  Is there a change to make sound work with some tweaking in 
dmasound.c or this something completely different?

  Gerd


[[ This message was sent via the linuxppc-dev mailing list. Replies are ]]
[[ not forced back to the list, so be sure to  Cc linuxppc-dev  if your ]]
[[ reply is of general interest. To unsubscribe from linuxppc-dev, send ]]
[[ the message 'unsubscribe' to linuxppc-dev-request@lists.linuxppc.org ]]
