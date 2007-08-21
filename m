Return-Path: <lim.taicom@gmail.com>
Received: from rv-out-0910.google.com (rv-out-0910.google.com [209.85.198.191])
	by ozlabs.org (Postfix) with ESMTP id 34662DDEAB
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 21 Aug 2007 13:22:14 +1000 (EST)
Received: by rv-out-0910.google.com with SMTP id c27so1183344rvf
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 20 Aug 2007 20:22:13 -0700 (PDT)
Date: Tue, 21 Aug 2007 11:21:40 +0800
From: "lim.taicom" <lim.taicom@gmail.com>
To: linux-kernel@vger.kernel.org <linux-kernel@vger.kernel.org>
Subject: lim_nfs problem
Message-ID: <200708211121367633321@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
	boundary="=====001_Dragon662066552687_====="
Cc: linux-arch@vger.kernel.org,
	linuxppc-embedded <linuxppc-embedded@ozlabs.org>
Reply-To: lim.taicom@gmail.com
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

This is a multi-part message in MIME format.

--=====001_Dragon662066552687_=====
Content-Type: text/plain;
	charset="gb2312"
Content-Transfer-Encoding: 7bit

hello:
I have some question when I use nfs on my own board.
but there is some error like this:

Root-NFS: Server returned error -13 while mounting /home/lim/Ramdisk
VFS: Unable to mount root fs via NFS, trying floppy.
VFS: Cannot open root device "nfs" or 02:00
Please append a correct "root=" boot option
Kernel panic: VFS: Unable to mount root fs on 02:00

But in my nfs server ,i can use mount -t nfs localhost:/home/lim/Ramdisk to everywhere i want
what is problem?
--=====001_Dragon662066552687_=====
Content-Type: image/gif;
	name="man_010.gif"
Content-Transfer-Encoding: base64
Content-Disposition: FoxmailIcon;
	filename="man_010.gif"

R0lGODlhKAAoAPcBACkjASgiASskAS8oATkvADswAD8xAUIvA0MrB0QoCkQnC0UnDEcoDUssEEwv
EU0vEk4vEk4wEk8wE1AzE1I2FVU4F1g6GVk7GFo8F1s8FVo7EVk5C1k5B1o5BVw4BF82A2I1AmU1
Amk3Ams5Am47AnE9A3Q/A3pBBX5CBntEBXhHA3dKAnhNAntRAX9UAYVXAolbA4xfAo9jApBmAY9o
AZFtAZJvAZFvA41qB4poC4ZkD4BeFH1aGXtWH3tTI3xTJX1TJnxTJntSJnlRJnVQJ3BOKG1NKGlL
K2dMLWRNMWFQNl9SO19UP2JWQmZaRmlbR21cSHFcR3NcRHZcQXpcPX9dOYRfOIlgNY5iNZNkNJhm
NJpoNZxpOKBtPKFwQKJxQqJyRKFzRp9zSZxzTJdzUI9yVYZxW4RzYoJ0ZYF2aYJ4bIN7cIV/doeE
fIeIgYmLhYuQjZKXlJebmZudm56gnqKfmqSdlqeajK2WfbSSbriPZLqMXr+MWMOMVMmMTs2MS8yL
SMmIRcaEQsKBP8B+Pb97Ob5zMbtoJbpiHrldGsBTEcVNC8tMCdBMB9JOBtJUB9JiCtRwDdZ1D9N9
EMyGDcmQCs2VCs6ZCt6iCeepCfCzCfW6CvjCDfrLEPzTEv3ZFP7cFf3eFv3gGfzZIfq+QfmxVPms
XPmrXvmqXfioWvinV/inVvimVvemVvSjVPChU+2eUemdUuScVd+eX9ygZduiadulb+GqceivdPGy
c/azcfi1cvm3dPq3dfq5d/q6evm7ffm8gfm+g/m/hfnAiPrDjPrFkPvGkvzJlvzLmvzMnfzNn/vO
ovrOpO/MqdLEtcC/vLm9wLa9xLjAx7/GzMXL0MPO18HQ3sDT5cDX68Da8sLe98Tg+sXh/Mbj/sbj
/sbj/sfj/sfj/sfj/sfj/sfj/sfj/s/i9Nfg6Nrf4t/h4+Tk5Ofn5+rq6u3t7e/v7/Hx8fPz8/Pz
8/X19fb29vf39/n5+fr6+vv7+/39/f39/f7+/v7+/v7+/v7+/v7+/iH5BAgAAAEALAAAAAAoACgA
AAj+ALkJHEiQ4DU4TiwUWMikoRs62gpKnDiRDpOFHVrY2FiDBosOC51Eo0iS4LSLHWhculTJBqVK
lVhubAGSyciSFQkYkGGjBowXQFu8gAGjxkYbMlgYKLAGZ8E1BTzMULqwatUOI4Z2fNGCQwElEZ3S
KdABJIUxtowhQ2aMGC4+VgoYGOFCRowWKkJ8DUtSGoGFR2wxY5as8FpiiIPlIkKWBdcVI/Q6KanN
QQEKtpoNHmzMlh4xemzhIhbsVyCyJ1qwGCECRAE4FOlAceDAyBhczZoZsxKhd5TeEY7s+WW6wIgT
LFSwNuCAr8CTEaKoUXMGSYTbFqRAaweve7toZiL+YPnli4gBFehHgHANe6A2JkmgpZtvDRqbCNnt
6d8Pr106OxF44QstBXCQ3noGKEHQGxZUw51361SjRgTp7GchPBGeYcEvu1hxXgnqgfBBAdcMlIQa
3F24DhtIWHihf3REMMsufBgHYogF0CGQNhFAA4+L9sBjhhlA8pcONBh4sYsuBnBwI4JuCCRNBOtY
OEcAdMATxR32MBFAOy5iCI0SSupihAFPgmBAlNxM+eN+XjKhJZcBBABNmOuMWeYWaI7wQQMKJNBU
m1RamEYAbMxpT50V8ucfNEnsWcAHCjSQRRc+KCANNzzeaWE1QQ5pj39htmMNHUku6QcBGWihiiz+
sKhSBBQCWXDHm4620SKQ/R0Jh4yqFhCLKqp0AcQWhTggUBpHrNOdfr260SOuEFZDRxQW+LKkLAUE
QuyrVnShgEDXWGCGNeu008461thhQXbqdNffOulUE80aAS6pyymDAPJqrFuIO9A070bRRhtnJBEB
GbhYcIQd1dAHDRxPiMfhvqeY4kqxf6jyR7IESdOAEVSUPMYtnJEB3MpF8EHekhlrrMoWghDrA60E
OaDHZjwTlowtQNtSCzClXbyvKaYUUkggQGTxhwI6DiSNAoL1XJhhbSVGnC+5gFHFFbKokogCWchC
SAOTEWQBFYX5fDXWiGlt9ClfZKHKJDsooDf+FM5Njcvbb6+Vtdz6EiJIK1bcnYgD0zgnkBtHrKXH
HrasJfjgpG3dxxUTWGpKrJMgokCJEkFujDF7NADoEUWIAVottdDChxdYFBHoBBg0EDaxkkgC9URT
IzZMAhhYMEHnquutt+oTVPCupd+q0vsIaOBRBuk7KqAHYmQ08O73FmRwAvjfN4BBrN9OIgkMDqiQ
nB0EQVFEMMQAYzz4KDiifyOLoGBB7ueL3t0kEQkOsEAUlyiBFQamADH8Ihi1UN278qc//fVvAgoI
oABhIQlInOASohAFJ2BAEDcowGW/oIUFEjCBRVTQgiFQgKv+FT1XQAIFMQihKD7RiYKgQQGvYdjF
LnLRhQYwIAQoQIEIQtAAIOwuEE0UIAxY0IkQfsITPSyICYtAC1148Q9c4MIWtuAHpBFLCwoAQvRa
wQMq7vCKneAE8JaQRkGc4o5IM6MqAoEBBXQheoBAgRvhGMdNkIQOTqiUD2gWiEZqIQMKKMLuVBGL
Q5QAB6DYIRY5wYlNaAIn16ADGhKpPAskUo2vsuQLQHjFTW7Ck590CkWmpoUdlGCVVtxkJzXBy0wE
BAA7

--=====001_Dragon662066552687_=====--
