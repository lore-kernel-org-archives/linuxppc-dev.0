From: "Rick Hunnicutt" <rhunnicutt@getntds.com>
To: <linuxppc-embedded@lists.linuxppc.org>
Subject: MVME 5100 flash programming
Date: Wed, 19 Dec 2001 12:35:35 -0800
Message-ID: <000201c188cc$b6a5a720$8df859c7@get.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hello all,

I have a 5100 running the 2.4.2 kernel and want to use the onboard flash.
With PPC_Bug, we are able to program the 16M area with a kernel and RAM disk
image and boot. At the very least, I'd like to use some of the remaining
flash area as a read/write area for configuration data. Ideally, I'd like
the whole flash area to be a JFFS file system using MTD and the CFI
interface.

Problem is, I am unable to get the flash to respond to any type of query.
The MTD code fails to get a response to the CFI query. Other code that tries
to perform a simple query of the chips Manufacture ID fails as well. I can
read the data in the flash that was written by pflash but can't seem to get
writes to occur.

Anyone using the flash on a 5100 at all? Any ideas, code samples, help at
all would be appreciated!

Thanks,
Rick


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
