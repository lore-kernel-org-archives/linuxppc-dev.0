Message-ID: <37C3EF54.1B04E967@cable.a2000.nl>
Date: Wed, 25 Aug 1999 15:27:48 +0200
From: Otto Moerbeek <otto@cable.a2000.nl>
MIME-Version: 1.0
To: linux-kernel@vger.rutgers.edu, linuxppc-dev@lists.linuxppc.org
Subject: Re: General purpose serial PCI driver available for testing 
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi to you all,

The third version of the serial driver PCI patch is available at my
little site <http://people.a2000.nl/omoerbe/>. The maximum number of PCI
serial ports supported can now be configured at config time. Also, an
error introduced in include/asm-i386/serial.h is fixed. Actually, this
file and include/asm-alpha/serial.h are not patched at all anymore. 

Regards,
Otto

-- 
Otto Moerbeek
otto@cable.a2000.nl

[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
