From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: <paulus@samba.org>
Cc: <linuxppc-dev@lists.linuxppc.org>,
	Stefan Jeglinski <jeglin@4pi.com>
Subject: Re: 2.4.13-pre5 crash when mounting proc
Date: Sun, 21 Oct 2001 20:58:12 +0200
Message-Id: <20011021185812.24126@smtp.wanadoo.fr>
In-Reply-To: <15314.48871.176187.508759@cargo.ozlabs.ibm.com>
References: <15314.48871.176187.508759@cargo.ozlabs.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


>> On boot, when it gets to "mounting proc
>> filesystem," I get a break into the mon debugger, but I have no
>> keyboard response (so no backtrace). The info I can copy is:
>
>You have an ADB keyboard, no?  I am surprised the keyboard doesn't
>respond.

Could be async probing not beeing complete. I could push the adb_sync
kernel arg to the bk trees, at least _devel.

>> vector: 300 at pc = c02432fc lr = c00544e0 msr = b032 sp = c5dc3ef0
>>
>> plus some more that I'm not sure will help much. For this output
>> alone, should I include System.map also?
>
>Yes, or alternatively find out where those pc and lr addresses are in
>the System.map list and tell us the nearest symbols and their values.
>
>> Is this a known problem?
>
>Not to me...

Not to me neither but I'm still running pre3.

Ben.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
