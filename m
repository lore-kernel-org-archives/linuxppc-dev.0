Content-Type: text/plain;
  charset="iso-8859-1"
From: "Kevin B. Hendricks" <khendricks@ivey.uwo.ca>
Reply-To: khendricks@ivey.uwo.ca
To: David Edelsohn <dje@watson.ibm.com>
Subject: Re: gcc 2v optimization problem with C++ exceptions?
Date: Tue, 10 Apr 2001 17:14:06 -0400
Cc: Franz Sirl <Franz.Sirl-kernel@lauterbach.com>,
	linuxppc-dev@lists.linuxppc.org
References: <200104102051.QAA20310@makai.watson.ibm.com>
In-Reply-To: <200104102051.QAA20310@makai.watson.ibm.com>
MIME-Version: 1.0
Message-Id: <01041017140600.09487@localhost>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi,

On Tuesday 10 April 2001 16:51, David Edelsohn wrote:
> I am confused why the disassembly contains values like 0x78364e55
> and 0x78664476 because those seem like 64-bit PowrePC instructions.
>
> David

Please ignore the dissassembly (as I mentioned in my e-mail).  The objdump -D
will try to disassemble everything including the __EXCEPTION__TABLE__ entries.

The table entries (i.e. data) are what was different, they are not
instructions AFAIK.

Kevin


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
