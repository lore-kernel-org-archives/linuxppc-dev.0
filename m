Date: Wed, 6 Jan 1999 09:41:57 +1100
Message-Id: <199901052241.JAA04815@tango.anu.edu.au>
From: Paul Mackerras <paulus@cs.anu.edu.au>
To: brad@pht.com
CC: linuxppc-dev@lists.linuxppc.org, p1rabbit@halcyon.com
In-reply-to: <Pine.LNX.3.96LJ1.1b7.990104192040.452A-100000@cricket> (message
	from Brad Midgley on Mon, 4 Jan 1999 19:41:15 -0700 (MST))
Subject: Re: 2.2.0pre2 SCSI problems, more (fwd)
Reply-to: Paul.Mackerras@cs.anu.edu.au
References: <Pine.LNX.3.96LJ1.1b7.990104192040.452A-100000@cricket>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Brad Midgley <brad@pht.com> wrote:

> i removed all devices from the second bus except for an 80M quantum drive
> that i used to boot from.  (everyone should be warned that you should boot
> from a non-mesh device when mesh debugging is on! :) 
> 
> a strange thing, and maybe bad news for debugging: the drive is discovered
> properly by the debugging kernel. maybe it's a timing issue. i hope the
> logs can tell you something. 

A timing issue sounds likely, as nothing much has changed in the mesh
driver (or the rest of the SCSI code AFAIK) lately.  If you set
mesh_debug_targets back to 0 but still have MESH_DBG defined, it won't
print all that debugging info but it will still record all the log
information (which is a relatively lightweight thing to do), and if
you get the target aborting, it will print the log.

Paul.

[[ This message was sent via the linuxppc-dev mailing list. Replies are ]]
[[ not forced back to the list, so be sure to  Cc linuxppc-dev  if your ]]
[[ reply is of general interest. To unsubscribe from linuxppc-dev, send ]]
[[ the message 'unsubscribe' to linuxppc-dev-request@lists.linuxppc.org ]]
