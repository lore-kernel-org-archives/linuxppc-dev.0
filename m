Message-ID: <38993D7F.B0964A77@dalim.de>
Date: Thu, 03 Feb 2000 09:34:07 +0100
From: Stephane GEORGES <sg@dalim.de>
MIME-Version: 1.0
CC: linuxppc-dev@lists.linuxppc.org
Subject: Speed tests - G4-400 and PIII-600
References: <88732CD95EB64875C125687900681C6E.00681C98C1256879@kehl.dalim.de>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


I've made speed tests on programs running on my LinuxPPC on G4-400 Mhz AGP,
and on Pentium III 600 Mhz.

Both machines have same disks performances (with hdparm, about 20 Mo/s).

GCC versions:
    - on Intel : egcs-1.1.2-24
    - on PowerPC: egcs-1.1.2-12c

Bogomips:
    - on Intel : ~ 600
    - on PowerPC: ~ 800

The test programs are dealing with run-length images processing.

I was disapointed by the fact that the Intel machine ran 25% faster
than the PowerPC machine.

I thought that a G4-400 was worth a PIII-800 ...
Maybe gcc including Alvitec patches will provide better performances ...

--

/====================================================================/|
| Stephane GEORGES                     |                             ||
| DALiM SOFTWARE GmbH      R&D         |    Tel: +49 7851 9196 40    ||
| Strassburger Str.6                   |    Fax: +49 7851 7357 6     ||
| D-77696                              |                             ||
| Kehl-Sundheim (Germany)              |    E-mail: sg@dalim.de      ||
|____________________________________________________________________|/


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
