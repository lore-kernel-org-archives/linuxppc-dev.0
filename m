Message-Id: <199901152240.QAA07784@lists.linuxppc.org>
Date: Fri, 15 Jan 1999 17:40:47 -0500 (EST)
From: "Jim Somerville" <somer@nortelnetworks.com>
Reply-To: "Jim Somerville" <somer@nortelnetworks.com>
Subject: Re: MCP750 and CPX2000 System Scsi Woes
To: Gabriel Paubert <paubert@iram.es>
cc: linuxppc-dev@lists.linuxppc.org, valette@crf.canon.fr,
        "Corey Minyard" <minyard@nortelnetworks.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


In message "Re: MCP750 and CPX2000 System Scsi Woes", 
"Gabriel Paubert" <paubert@iram.es> writes:
>Not very surprising, which is the actual interrupt used for SCSI
>(it should be in the doc and in the residual data).
>
>Tell me if the zImage-2.2.0-pre5 on ftp://vcorr1.iram.es/pub/ works
>better. Early boot messages will be different and it will try to use
>the OpenPIC (that's the image running on my MVME2600 right now).
>I'm completely reorganizing my source code and patches, hopefully
>I'll be able to make it available during the week-end. 

Gabriel, it worked!  SCSI devices were found successfully.  It died at the
end trying to mount the non-existent root partition.  If you have a
ramdisk image that contains an installer, it would be appreciated.  :-)
I'll look for your source on Monday.

Thanks again,

-Jim




[[ This message was sent via the linuxppc-dev mailing list. Replies are ]]
[[ not forced back to the list, so be sure to  Cc linuxppc-dev  if your ]]
[[ reply is of general interest. To unsubscribe from linuxppc-dev, send ]]
[[ the message 'unsubscribe' to linuxppc-dev-request@lists.linuxppc.org ]]
