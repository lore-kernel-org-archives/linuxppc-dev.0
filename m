From: "Stefano Coluccini" <s.coluccini@caen.it>
To: "Shoudong Xu" <Shoudong.Xu@cern.ch>
Cc: "linuxppc-embedded" <linuxppc-embedded@lists.linuxppc.org>
Subject: RE: convert  root file system to a binary file
Date: Tue, 10 Apr 2001 09:40:38 +0200
Message-ID: <NDBBIFIMCKPOADMAJOKMCEBPDBAA.s.coluccini@caen.it>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="gb2312"
In-Reply-To: <003101c0c129$d7458010$9e648a89@cern.ch>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


>
> Could you tell me how to convert a small root file system (It has
> be compressed by me ,now just 6Meg) to a binary file which can be
> burnt into flash  ?
>
> *the file system contain some directories bin lib etc ...

How do you see the flash memory ? like an IDE disk ? or like a RAM ?

If you see it like a disk, you can use the dd utility.

Bye.
Stefano.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
