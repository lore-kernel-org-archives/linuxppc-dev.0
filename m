Message-Id: <9903272044.AA52736@marc.watson.ibm.com>
To: ggs@shiresoft.com
Cc: paubert@iram.es, linuxppc-dev@lists.linuxppc.org
Subject: Re: Apple Job Posting and Good News for LinuxPPC developers 
In-Reply-To: Message from Guy Sotomayor <ggs@shiresoft.com>
   of "Fri, 26 Mar 1999 22:27:59 PST." <199903270627.WAA18114@aragorn.shiresoft.com>
Date: Sat, 27 Mar 1999 15:44:54 -0500
From: David Edelsohn <dje@watson.ibm.com>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


>>>>> Guy Sotomayor writes:

Guy> Actually I think the 64bit PPCs are called PowerPC II.  They're reasonably
Guy> nice chips last time I looked.  They are expensive to put together in a
Guy> system (ie 8MB L2, 128bit data bus, etc).  Also the 6xx bus is a split
Guy> transaction bus, so the bus controllers are a bit more complex too.  I
Guy> also think that all the data paths are ECC'd with parity on addresses. 
Guy> For a good example on what type of systems are built using these things,
Guy> look at the S70 Advanced server.

	64-bit PowerPC is an architecture, not a single chip.  The first
implementation was the PPC620 from Somerset, eventually only used by
Groupe Bull.  The S70 and S7A use a chip from IBM Rochester also used in
AS/400s.  The Power3 (aka PPC630fp) is yet a third 64-bit PowerPC
implementation.  IBM's recent 64-bit PowerPC chips are augmented to
support additional requirements of AS/400 systems.

David

[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
