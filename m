Message-ID: <6B546A602AD2D211BFF00008C7A4288905843F87@hrtades2.atea.be>
From: Goddeeris Frederic <Frederic.Goddeeris@siemens.atea.be>
To: "'linuxppc-embedded@lists.linuxppc.org'" <linuxppc-embedded@lists.linuxppc.org>
Subject: FEC driver / multicast / Hash Table
Date: Thu, 20 Dec 2001 11:23:18 +0100
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


 Hi,

I am wondering why the code to calculate the CRC using SCC1 in
"set_multicast_list" of arch/ppc/8xx_io/fec.c is commented out. Is this
because it does not work, or is it because SCC1 needs to be off-line?

Did somebody perhaps implement the CRC calculation in SW? If not, I am
planning to do it....

Thanks,
Frederic

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
