Subject: Re: IBM 4xx drivers restructuring
To: Armin Kuster <Darth_vapor@mvista.com>,
	linuxppc-dev@lists.linuxppc.org
Message-ID: <OFBED55E6E.9276170C-ON85256B1F.005E0431@raleigh.ibm.com>
From: "Mark Wisner" <markwiz@us.ibm.com>
Date: Tue, 11 Dec 2001 12:09:49 -0500
MIME-Version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


You should add the MAL to the list of devices. It should not be included in
the EMAC driver. The MAL can be connected to different COMACs and there can
be multiple MALs.

Mark K. Wisner
Advisory Software Engineer
IBM Microelectronics
3039 Cornwallis Rd
RTP, NC 27709
Tel. 919-254-7191
Fax 919-543-7575


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
