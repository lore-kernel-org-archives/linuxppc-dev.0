Message-Id: <9911022024.AA40132@marc.watson.ibm.com>
To: "Florent" <flobo@iname.com>
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: Newworld OF boot 
In-Reply-To: Message from "Florent" <flobo@iname.com>
   of "Tue, 02 Nov 1999 19:32:19 +0100." <381f2fd9382470a6@villosa.wanadoo.fr>.(added.by.villosa.wanadoo.fr)
Date: Tue, 02 Nov 1999 15:24:37 -0500
From: David Edelsohn <dje@watson.ibm.com>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


	I have seen documentation about OF accepting XCOFF, but I am not
sure exactly how it is suppose to work.  I assume that the XCOFF image
needs something equivalent to the ELF OF note section to specify loading
parameters. 

	I have not heard of a FreeBSD PowerPC port, but NetBSD does have a
Mac PowerPC port.  NetBSD seems to create an OF note section. 

	The last I checked, Linux/PPC creates an ELF kernel which it then
prepends an XCOFF header for PreP booting, and then there seemed to be
some work to package the XCOFF image within an ELF header again.  If
someone added a correct OF note section to the first ELF executable, Mac
OF should be happy.  The necessary pieces have been described numerous
times in this mailinglist, but everyone seems to be infatuated with Rube
Goldberg solutions.

David

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
