Date: Fri, 3 May 2002 19:52:28 -0300
From: Ricardo Scop <scop@vanet.com.br>
Reply-To: Ricardo Scop <scop@vanet.com.br>
Message-ID: <6828.020503@vanet.com.br>
To: Jean-Denis Boyer <jdboyer@mediatrix.com>
Cc: "'Steve.Ferri@radisys.com'" <Steve.Ferri@radisys.com>,
	linuxppc-embedded@lists.linuxppc.org
Subject: Re[2]: Unhandled interrupt 0, disabled
In-reply-To: <F1BED55F35F4D3118C0F00E0295CFF4DFF9FDE@mail.mediatrix.com>
References: <F1BED55F35F4D3118C0F00E0295CFF4DFF9FDE@mail.mediatrix.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Mr. Jean-Denis,

I think I forgot to feed you back about that fix. We have a 8255,
1K22A mask, with linux 2.4.16, and the fix worked well, thanks!

-- Scop                            mailto:scop@vanet.com.br

------------------------------------------------------------------
"We all lie in the gutter, but some of us look up at the stars."
-- Oscar Wilde

Friday, May 03, 2002, 12:22:00 PM, you wrote:

>> Which fix are you standing behind your __sti()
>> fix using the sync or the 2.4.18 patch ?

JDB> Just put the 'sync' in __sti().
JDB> It seems to fix the problem on both 2.4.10 and 2.4.18,
JDB> which are the versions I have tested.

>> I am using the B.3 version of the 8260

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
