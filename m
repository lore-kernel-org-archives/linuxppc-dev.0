Message-Id: <9901251744.AA90074@marc.watson.ibm.com>
To: Samuel Rydh <samuel@ibrium.se>
Cc: Tom Harrington <tph@rmi.net>, linuxppc-dev@lists.linuxppc.org
Subject: Re: mac-on-linux project status 
In-Reply-To: Message from Samuel Rydh <samuel@ibrium.se>
   of "Mon, 25 Jan 1999 16:12:52 +0100." <v03130305b2d231353f9c@[192.168.0.1]>
Date: Mon, 25 Jan 1999 12:44:11 -0500
From: David Edelsohn <dje@watson.ibm.com>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


	One of the changes from the original POWER architecture to the
PowerPC architecture was "virtualizing" the instructions so that a
hypervisor-like OS could virtualize the processor and allow hosted
operating systems on a virtual machine.

	The hosted operating system thinks that it is running on hardware
but all privileged operations trap to the hypervisor.

David


[[ This message was sent via the linuxppc-dev mailing list. Replies are ]]
[[ not forced back to the list, so be sure to  Cc linuxppc-dev  if your ]]
[[ reply is of general interest. To unsubscribe from linuxppc-dev, send ]]
[[ the message 'unsubscribe' to linuxppc-dev-request@lists.linuxppc.org ]]
